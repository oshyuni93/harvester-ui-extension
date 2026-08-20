# 4. 이미지 관리

> 가상 머신(VM)의 다양한 OS 이미지 설정

---

## 지원 OS 이미지

Infinitystack은 `.qcow2` 형식의 이미지를 SDS(Longhorn)에 등록하여 VM 생성에 사용합니다.

| OS | 지원 여부 |
|----|----------|
| Red Hat / Rocky Linux | ✅ |
| SUSE Linux | ✅ |
| Ubuntu | ✅ |
| CentOS | ✅ |
| Windows Server | ✅ |

---

## STEP 1. 이미지 생성 메뉴 접속

**경로:** 좌측 메뉴 → **이미지** → **생성** 버튼 클릭

---

## STEP 2. 기본 정보 입력

| 항목 | 입력값 |
|------|--------|
| **네임스페이스** | `default` |
| **이름** | `ubuntu2204` (예시) |
| **기본 정보 유형** | `URL` 선택 |
| **URL** | Ubuntu 이미지 URL 입력 |

**Ubuntu 22.04 이미지 URL 예시:**
```
https://cloud-images.ubuntu.com/jammy/20250620/jammy-server-cloudimg-amd64-disk-kvm.img
```

---

## STEP 3. 스토리지 정보 확인

| 항목 | 값 |
|------|-----|
| **스토리지 클래스** | `harvester-longhorn (기본)` |

---

## STEP 4. 레이블 정보 설정

이미지 타입과 OS 타입을 레이블로 지정합니다.

| 키 | 값 |
|----|-----|
| `harvesterhci.io/image-type` | `raw/qcow2` |
| `harvesterhci.io/os-type` | `Ubuntu` |

**생성** 버튼 클릭

---

## STEP 5. 상태 확인

이미지 목록에서 생성된 이미지가 정상 적재 되었는지 확인합니다.

| 항목 | 확인 내용 |
|------|----------|
| **상태** | `Active` (완료됨) |
| **스토리지 클래스** | `harvester-longhorn` |
| **크기** | 업로드된 이미지 크기 |

!!! success "완료"
    상태가 `Active`로 표시되면 VM 생성 시 해당 이미지를 사용할 수 있습니다.
