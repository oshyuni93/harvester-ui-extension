#!/bin/bash
# ==============================================================================
# Harvester GPU Monitoring Auto-Deployment & Dynamic IP Sync Daemon
# ==============================================================================
(
  echo "[GPU-Monitoring] Waiting for Kubernetes API availability..."
  max_retries=60
  count=0
  until kubectl get ns >/dev/null 2>&1 || [ $count -ge $max_retries ]; do
    sleep 5
    count=$((count+1))
  done

  if [ $count -ge $max_retries ]; then
    echo "[GPU-Monitoring] Kubernetes API not available after $((max_retries*5)) seconds. Skipping auto-deploy."
    exit 1
  fi

  echo "[GPU-Monitoring] Kubernetes API is ready. Applying Harvester GPU monitoring stack..."
    # 이전 default 네임스페이스에 생성되었던 레거시 리소스 정리 (중복 스크랩 방지)
  kubectl delete servicemonitor vm-gpu-server-dcgm -n default 2>/dev/null || true
  kubectl delete service vm-gpu-server-dcgm -n default 2>/dev/null || true
  kubectl delete endpoints vm-gpu-server-dcgm -n default 2>/dev/null || true

  if [ -f /var/lib/harvester/manifests/harvester-gpu-monitoring-stack.yaml ]; then
    kubectl apply -f /var/lib/harvester/manifests/harvester-gpu-monitoring-stack.yaml
    echo "[GPU-Monitoring] Manifests applied successfully."

    # Grafana pod 재시작하여 대시보드 리로드
    echo "[GPU-Monitoring] Rolling out restart for rancher-monitoring-grafana..."
    kubectl rollout restart deployment -n cattle-monitoring-system rancher-monitoring-grafana || true
  else
    echo "[GPU-Monitoring] Warning: /var/lib/harvester/manifests/harvester-gpu-monitoring-stack.yaml not found."
  fi

  # ============================================================================
  # Dynamic GPU VM Auto-Discovery Daemon Loop
  # Harvester KubeVirt의 VMI 정보를 주기적으로 조회하여 GPU가 할당된 VM의 IP를
  # 자동으로 Endpoints(vm-gpu-server-dcgm)에 반영합니다.
  # 가상머신이 재부팅되거나 재생성되어 IP가 변경되더라도 자동 동기화됩니다.
  # ============================================================================
  echo "[GPU-Monitoring] Starting Dynamic GPU VM Discovery Daemon..."
  while true; do
    sleep 60

    # 1. KubeVirt VMI 목록에서 hostDevices(GPU)가 할당되어 있고 러닝 중인 VM의 IP 목록 수집
    DISCOVERED_IPS=$(kubectl get vmi -A -o json 2>/dev/null | grep -B 30 -A 30 '"hostDevices"' | grep -oE '192\.168\.[0-9]+\.[0-9]+' | sort -u || true)

    # 수집되지 않았을 경우를 대비해 kubectl jsonpath 기반으로도 확인
    if [ -z "$DISCOVERED_IPS" ]; then
      DISCOVERED_IPS=$(kubectl get vmi -A -o jsonpath='{range .items[*]}{.status.interfaces[*].ipAddress}{" "}{end}' 2>/dev/null | tr ' ' '\n' | grep -v '^$' | sort -u || true)
    fi

    if [ -n "$DISCOVERED_IPS" ]; then
      # Endpoints YAML 조립
      ADDR_BLOCK=""
      for ip in $DISCOVERED_IPS; do
        ADDR_BLOCK="${ADDR_BLOCK}  - ip: ${ip}\n"
      done

      CURR_ENDPOINTS=$(kubectl get endpoints -n cattle-monitoring-system vm-gpu-server-dcgm -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null | tr ' ' '\n' | grep -v '^$' | sort -u || true)

      if [ "$DISCOVERED_IPS" != "$CURR_ENDPOINTS" ]; then
        echo "[GPU-Monitoring] Detected GPU VM IP change. Syncing Endpoints..."
        echo "[GPU-Monitoring] Discovered IPs: $DISCOVERED_IPS"
        cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Endpoints
metadata:
  name: vm-gpu-server-dcgm
  namespace: cattle-monitoring-system
subsets:
- addresses:
$(echo -e "$ADDR_BLOCK")  ports:
  - name: gpu-metrics
    port: 9400
EOF
        echo "[GPU-Monitoring] Endpoints vm-gpu-server-dcgm updated."
      fi
    fi
  done
) &
