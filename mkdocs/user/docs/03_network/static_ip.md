# Static IP 연결 설정 (Untagged)

> VM 네트워크를 위한 Untagged (Static IP 연결) 설정

---

## 가상 머신 네트워크 생성 (Management)

**경로:** 네트워크 → **가상 머신 네트워크** → **생성** 버튼

| 항목 | 입력값 |
|------|--------|
| **네임스페이스** | `default` |
| **이름** | `vlan1-net` |
| **유형** | `UntaggedNetwork` |
| **클러스터 네트워크** | `mgmt` |

!!! info "UntaggedNetwork 사용 시"
    호스트의 관리 네트워크와 동일하게 사용하게 됩니다. Static IP를 할당할 VM에 사용합니다.

---

## VM Static IP 할당 (Cloud-Init)

VM 생성 시 **고급 옵션** → **네트워크 데이터**에 Cloud-Init YAML을 작성합니다.

!!! warning "지원 범위"
    Cloud-Init을 지원하는 VM만 설정 가능합니다.
    **Windows VM**은 VNC 콘솔로 로그인 후 수동으로 직접 설정해야 합니다.

### 네트워크 데이터 템플릿

```yaml
network:
  version: 2
  ethernets:
    enp1s0:                          # VM의 인터페이스명 (OS별로 다름)
      dhcp4: false
      dhcp6: true
      addresses:
        - 192.168.104.201/24         # 원하는 고정 IP와 서브넷 마스크
      gateway4: 192.168.104.1        # 게이트웨이 주소
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

!!! note "OS별 인터페이스명"
    - **Rocky Linux:** `eth0`
    - **Ubuntu:** `ens0...`, `enp1s0..` 등

!!! warning "IP 충돌 주의"
    L3 switch의 DHCP Server와 혼용해서 사용한다면 IP 충돌을 위해서 **"IP 목록 관리"**, **"DHCP 예외IP 관리"**를 해야 합니다.
