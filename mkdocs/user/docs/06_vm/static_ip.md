# VM Static IP 할당

---

## Cloud-Init을 통한 Static IP 설정

VM 생성 시 **고급 옵션** → **네트워크 데이터** 탭에서 설정합니다.

!!! warning "지원 범위"
    Cloud-Init을 지원하는 VM만 설정 가능합니다.
    **Windows VM**은 VNC 콘솔로 로그인 후 수동으로 직접 설정해야 합니다.

### 네트워크 데이터 YAML

```yaml
network:
  version: 2
  ethernets:
    enp1s0:                          # OS별 인터페이스명 확인 필요
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

### OS별 인터페이스명

| OS | 인터페이스명 |
|----|------------|
| Rocky Linux | `eth0` |
| Ubuntu | `ens0...`, `enp1s0..` 등 |

!!! warning "IP 충돌 방지"
    L3 switch의 DHCP Server와 혼용하는 경우 IP 충돌을 방지하기 위해 **"IP 목록 관리"**, **"DHCP 예외IP 관리"**를 반드시 설정해야 합니다.
