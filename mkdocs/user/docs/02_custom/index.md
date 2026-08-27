# 2. 사용자 정의 설정

> 애드-온을 활용한 대시보드 구성 확장

---

## 모니터링 활성화

Infinitystack의 애드-온 기능으로 Prometheus/Grafana 기반 모니터링을 활성화합니다.

**경로:** 고급 → **애드-온** → `rancher-monitoring` 선택 → **활성화**

### 주요 애드-온 목록

| 애드-온 | 설명 |
|---------|------|
| `rancher-vendor (설치됨)` | IPMI 및 Redfish를 사용하여 노드에 대한 정보를 관리하고 각 작업을 할당하는 애드온 |
| `nvidia-driver-toolkit` | vGPU 장치를 활성화하여 Infinitystack 가상 머신에서 고성능 그래픽을 활성화하는 애드온 |
| `pcidevices-controller` | PCI 디바이스를 감지하고 관리하며 Infinitystack 가상 머신에서 PCI 리소스를 사용할 수 있도록 클러스터 준비 상태를 유지 |
| `rancher-logging` | Infinitystack 클러스터의 다양한 로그 및 감사 로그를 수집하고 트레픽 메시 이하 클러스터의 서버 애플리케이션 로그를 관리 |
| **`rancher-monitoring`** | Infinitystack 클러스터의 가상 머신 메트릭을 수집하고, 사용된 인시텐트에서 문제를 보고, 문서 서버 별을 통해 관련 서비스 정보를 관리 |
| `vm-import-controller` | 다른 소스 클러스터에서 기존 Infinitystack 클러스터로 가상 머신을 마이그레이션하는 기능 지원 |

!!! info "활성화 방법"
    애드-온 목록에서 `rancher-monitoring`을 선택하고 우측 메뉴 → **활성화**를 클릭합니다.

---

## 대시보드 모니터링 시각화 확인

모니터링 활성화 후 대시보드에서 클러스터 전체 현황을 시각적으로 확인합니다.

**경로:** **대시보드** 클릭

### 확인 가능한 정보

| 구분 | 항목 |
|------|------|
| **클러스터 현황** | 호스트 수, 가상 머신 수, 가상 머신 네트워크 수 |
| **리소스 현황** | 이미지 수, 볼륨 수, 디스크 수 |
| **성능 지표** | CPU 사용률, 메모리 사용률, 스토리지 사용률 |
| **상세 메트릭** | CPU Utilization, Load Average, Memory Utilization |

!!! tip "모니터링 시각화"
    대시보드 하단의 **가상 머신 메트릭** 탭에서 각 VM별 CPU/메모리 사용률을 실시간으로 확인할 수 있습니다.
