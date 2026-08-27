# ISO 기반 VM 생성 — 개요

> Windows ISO 이미지를 사용하여 가상머신을 생성하고 OS를 직접 설치합니다.

---

## 구성 요소

![ISO 기반 VM 구성](images/s06_img01.png)
![ISO 기반 VM 흐름](images/s06_img02.png)
![ISO 기반 VM 단계](images/s06_img03.png)

---

## 생성 절차 요약

| 단계 | 페이지 |
|------|--------|
| **STEP 1** | [기본 정보 설정](iso_vm_basic.md) — VM 이름, CPU, 메모리, 템플릿 |
| **STEP 2** | [볼륨 및 네트워크 설정](iso_vm_network.md) — 스토리지, 네트워크 구성 |
| **STEP 3** | [Windows OS 설치](iso_vm_install.md) — Console에서 OS 설치 |
| **STEP 4** | [qemu-ga 수동 설치](iso_vm_qemuga.md) — Guest Agent 설치 |
| **STEP 5** | [원격 접속 설정](iso_vm_remote.md) — RDP 및 방화벽 설정 |
| **STEP 6** | [VM 재시작](iso_vm_restart.md) — 최종 재시작 및 IP 확인 |

!!! note "ISO 방식 특징"
    Windows는 cdrom으로 부팅한 후 추가 설치를 해야 합니다.
    Live 마이그레이션은 지원되지 않습니다.
