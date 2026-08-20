# 3. 네트워크 관리

> Infinitystack 네트워크 구성 및 VM 네트워크 생성

---

## Infinitystack 네트워크 구성

Infinitystack은 L3 스위치를 통해 관리 네트워크(VLAN1)와 VM 네트워크(VLAN101 등)를 분리하여 운영합니다.

```
연결망 (사용자)
     ↓
  L3 Switch
  ├── VLAN1 (Management)
  │   ├── Host-1 (eth01/eth02 → Mgmt-bond)
  │   │   ├── Network-cnofig-A → Cluster Network-A
  │   │   │   ├── VM-network-A ← VM0
  │   │   │   └── VM-network-B ← VM1
  │   └── Host-2 (eth03/eth04 → out-of-bound-bond)
  └── VLAN101 (VM Network)
      └── Host-2
          ├── Network-cnofig-C → Cluster Network-B
          │   ├── VM-network-C
          │   └── VM-network-D ← VM3
```

---

## 네트워크 구성 흐름

```
1. 클러스터 네트워크 생성 (ext-net / storage-net)
         ↓
2. 네트워크 구성 생성 (extconfig / storage-config)
         ↓
3. 가상 머신 네트워크 생성 (vlan102-net 등)
         ↓
4. VM 생성 시 네트워크 연결
```

---

## 이 챕터에서 다루는 내용

| 페이지 | 내용 |
|--------|------|
| [VM 네트워크 (VLAN)](vlan.md) | ext-net 클러스터 네트워크 및 VM VLAN 생성 |
| [Storage 네트워크](storage_network.md) | storage-net 클러스터 네트워크 생성 |
| [Static IP 할당](static_ip.md) | Untagged 네트워크 및 Static IP 구성 |
