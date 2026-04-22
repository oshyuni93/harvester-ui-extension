# 3. 네트워크 관리

> **Infinitystack 네트워크 구성**

---

## 네트워크 구성 개요

Infinitystack은 크게 세 가지 네트워크 영역으로 구성됩니다.

| 네트워크 유형 | 설명 |
|--------------|------|
| **관리 네트워크 (Mgmt)** | HCI 호스트 관리 및 VIP 통신 |
| **VM 네트워크** | 가상 머신 간 VLAN 기반 통신 |
| **Storage 네트워크** | 스토리지 복제 및 데이터 전송 전용 |

---

## 네트워크 아키텍처

아래 다이어그램은 Infinitystack의 전형적인 네트워크 구성을 보여줍니다.

```
                    L3 Switch
                        │
        ┌───────────────┼───────────────┐
        │               │               │
      Host-1          Host-2         Host-n
        │               │
   eth01 (Mgmt-bond / VLAN1)
   eth02 (Cluster Network-A)
   eth03 (out-of-bound-bond)
   eth04
```

**Host-1 구성 예시:**

- `eth01` → `Mgmt-bond` → `VLAN1` → VM0, VM-network-A
- `eth02` → `Network-config-A` → `Cluster Network-A`
- `eth03` → `out-of-bound-bond`

**Host-2 구성 예시:**

- `eth01` → `Mgmt-bond` → `VLAN101` → VM-network-C
- `eth02` → `연결망` → `Cluster Network-B` → `Network-config-C`
- `eth03` → `out-of-bound-bond`

---

## 주요 섹션

- [VM 네트워크 구성](vm-network.md) - ext-net 기반 VLAN 설정
- [Storage 네트워크 구성](storage-network.md) - storage-net 구성
- [Static IP 할당](static-ip.md) - untagged 네트워크 및 Static IP 설정

---

!!! tip "네트워크 계획 팁"
    클러스터 노드 환경에서는 반드시 "모든 노드 선택"을 사용하고, 싱글 노드 환경에서는 "특정 노드 선택"을 사용하세요.
