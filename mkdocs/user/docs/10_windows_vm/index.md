# 10. Windows 가상머신 관리

> Windows ISO 및 QCOW2 이미지 기반 가상머신 생성 및 관리

---

## Windows VM 생성 방식

Infinitystack에서 Windows 가상머신을 생성하는 방법은 두 가지입니다.

| 방식 | 설명 | Live 마이그레이션 |
|------|------|:-:|
| **ISO 기반** | Windows 설치 ISO를 직접 업로드하여 OS 설치 | ❌ |
| **QCOW2 기반** | 사전 설치된 QCOW2 디스크 이미지로 즉시 생성 | ✅ |

---

## 📋 전체 절차

| # | 페이지 | 주요 내용 |
|---|--------|----------|
| 1 | [ISO 이미지 등록](image_register.md) | Windows ISO 파일 업로드 및 이미지 생성 |
| 2 | [이미지 상태 점검](image_status.md) | 업로드 완료 후 Active 상태 확인 |
| 3 | [ISO 기반 VM — 개요](iso_vm_overview.md) | ISO 방식 VM 생성 절차 개요 |
| 4 | [ISO 기반 VM — 기본 정보 설정](iso_vm_basic.md) | VM 이름, CPU, 메모리, 템플릿 선택 |
| 5 | [ISO 기반 VM — 볼륨 및 네트워크 설정](iso_vm_network.md) | 스토리지, 네트워크 구성 |
| 6 | [Windows OS 설치](iso_vm_install.md) | Console 접속 후 Windows 설치 진행 |
| 7 | [qemu-ga 수동 설치](iso_vm_qemuga.md) | QEMU Guest Agent 설치 |
| 8 | [원격 접속 설정](iso_vm_remote.md) | RDP 및 방화벽 설정 |
| 9 | [VM 재시작](iso_vm_restart.md) | 설치 완료 후 재시작 및 IP 확인 |
| 10 | [QCOW 기반 VM — 개요](qcow_vm_overview.md) | QCOW2 방식 VM 생성 절차 개요 |
| 11 | [QCOW 기반 VM — VM 생성](qcow_vm_create.md) | QCOW2 이미지로 VM 즉시 생성 |
| 12 | [QCOW 기반 VM — Console 접속](qcow_vm_console.md) | Web VNC 접속 및 Static IP 설정 |

---

!!! info "사전 요건"
    Windows ISO 이미지 또는 QCOW2 이미지 파일이 준비되어 있어야 합니다.
