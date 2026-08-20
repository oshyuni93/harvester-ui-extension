# 백업 서버 구축 (MinIO)

> NFS/S3(ObjectStorage)를 백업 서버로 구축합니다.

---

## MinIO 서버 설치

별도의 Ubuntu 서버에서 MinIO를 설치하고 실행합니다.

### MinIO 다운로드 및 실행

```bash
# 데이터 디렉토리 생성
mkdir -p ~/minio-data

# 환경 변수 설정 (관리자 계정)
export MINIO_ROOT_USER=minioadmin
export MINIO_ROOT_PASSWORD=minioadmin

# MinIO 서버 백그라운드 실행
nohup minio server ~/minio-data \
  --address 0.0.0.0:9000 \
  --console-address 0.0.0.0:9001 \
  > ~/minio.log 2>&1 &
```

| 포트 | 용도 |
|------|------|
| `9000` | S3 API Endpoint |
| `9001` | 웹 콘솔 (브라우저 접속) |

---

## MinIO 웹 콘솔 접속 및 Bucket 생성

### 접속 정보

| 항목 | 값 |
|------|-----|
| **웹 콘솔 URL** | `http://[백업서버IP]:9001` |
| **API Endpoint** | `http://[백업서버IP]:9000` |
| **로그인 ID (access_key)** | `minioadmin` |
| **로그인 PW (secret_key)** | `minioadmin` |

### Bucket 생성

1. 웹 콘솔 로그인
2. 좌측 메뉴 → **Buckets** → **Create Bucket**
3. Bucket 이름: `infinitystack` 입력
4. **Create Bucket** 클릭

!!! success "버킷 구조"
    생성된 버킷 내에 `backupstore`, `harvester` 폴더가 자동으로 생성됩니다.

!!! tip "운영 환경 권장"
    운영 환경에서는 `MINIO_ROOT_PASSWORD`를 강력한 비밀번호로 변경하고,
    TLS 인증서를 적용하여 HTTPS로 운영하는 것을 권장합니다.
