# 6. VM 관리

> 가상 머신(VM)의 쉽고 편리한 생성 관리

---

## 개요

Infinitystack은 KubeVirt 기반의 가상화 환경에서 VM을 쉽게 생성하고 관리할 수 있습니다.

```
┌────────────────────────────────────────────┐
│            Infinitystack Cluster           │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐   │
│  │  Host-1  │ │  Host-2  │ │  Host-3  │   │
│  │ VM VM VM │ │ VM VM VM │ │ VM VM VM │   │
│  │──────────│ │──────────│ │──────────│   │
│  │Management│ │Management│ │Management│   │
│  │ Storage  │ │ Storage  │ │ Storage  │   │
│  │  Virt.   │ │  Virt.   │ │  Virt.   │   │
│  └──────────┘ └──────────┘ └──────────┘   │
└────────────────────────────────────────────┘
```

---

## 이 챕터에서 다루는 내용

| 페이지 | 내용 |
|--------|------|
| [VM 생성](create.md) | 기본 정보, 볼륨, 네트워크 설정으로 VM 생성 |
| [Static IP 할당](static_ip.md) | Cloud-Init을 통한 고정 IP 설정 |
| [볼륨 추가 및 마운트](volume.md) | 데이터 디스크 추가 및 Linux 마운트 |
| [스냅샷 및 백업](snapshot_backup.md) | VM 스냅샷 찍기, 백업 받기 |
