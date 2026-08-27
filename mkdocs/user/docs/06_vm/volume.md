# 볼륨 추가 및 마운트

---

## 방법 1. 사전 생성한 볼륨 추가

VM 목록에서 해당 VM → 우측 메뉴(⋮) → **볼륨 추가**

| 항목 | 입력값 |
|------|--------|
| **이름** | `data` |
| **볼륨** | `data-disk` (사전에 볼륨 메뉴에서 생성한 볼륨 선택) |

!!! info "사전 작업"
    사전에 **볼륨** 메뉴에서 `data-disk`를 생성한 후 조회하여 선택합니다.

**적용** 버튼 클릭

---

## 방법 2. 볼륨 직접 추가 (구성 편집)

VM 목록에서 해당 VM → 우측 메뉴(⋮) → **구성 편집**

볼륨 섹션에서 **볼륨 추가** 클릭 후:

| 항목 | 입력값 |
|------|--------|
| **이름** | `data` |
| **스토리지 클래스** | `harvester-longhorn (기본)` |
| **크기** | `10` GB |
| **버스** | `VirtIO` |

**저장** 버튼 클릭 → VM 자동 재시작

!!! note "VirtIO 선택 이유"
    VirtIO는 KVM/QEMU에 특화된 고성능 가상 디스크 드라이버 방식입니다.

---

## 볼륨 마운트 (Linux)

### 파티션 생성 및 포맷

VM에 SSH 접속 후 추가된 볼륨(`vdc`)을 확인하고 파티션을 만듭니다.

```bash
# 1. 디스크 확인 (추가된 볼륨 vdc 확인)
lsblk

# 2. 파티션 생성
sudo fdisk /dev/vdc
# n (새 파티션 생성)
# p (주 파티션 선택)
# 파티션 번호, 시작 및 끝 섹터는 기본값 사용
# w (변경 사항 저장)

# 3. 파티션 확인
lsblk

# 4. 파일 시스템 포맷
sudo mkfs -t ext4 /dev/vdc1
```

### 마운트

```bash
# 5. 마운트 지점 생성
sudo mkdir /mnt/data

# 6. 마운트
sudo mount /dev/vdc1 /mnt/data

# 7. 마운트 확인
df -h
```

### 자동 마운트 설정 (재부팅 후 유지)

```bash
# 8. UUID 확인
sudo blkid /dev/vdc1
# 출력 예시: UUID="bf68866a-0404-4978-a78b-417bb3de058a"

# 9. /etc/fstab에 추가
sudo vi /etc/fstab
# 아래 내용 추가:
# UUID="bf68866a-0404-4978-a78b-417bb3de058a" /mnt/data ext4 defaults 0 0
```

---

## LVM 구성 (고급)

더 유연한 볼륨 관리를 위해 LVM을 사용할 수 있습니다.

```bash
# Lvm2 설치
sudo apt update && sudo apt install lvm2 -y

# Physical Volume (PV) 생성
sudo pvcreate /dev/vdb

# Volume Group (VG) 생성
sudo vgcreate infinity-vg /dev/vdb

# Logical Volume (LV) 생성 (예: 10G보다 작게)
sudo lvcreate -L 9.9G -n data-lv infinity-vg

# 마운트 디렉토리 생성 및 마운트
sudo mkdir /mnt/data
sudo mkfs.ext4 /dev/infinity-vg/data-lv
sudo mount /dev/infinity-vg/data-lv /mnt/data

# 자동 마운트 UUID 획득
sudo blkid /dev/infinity-vg/data-lv

# /etc/fstab 추가
# UUID="cf5289bb-c4da-472a-8041-e8d88f0be1a6" /mnt/data ext4 defaults 0 0
```
