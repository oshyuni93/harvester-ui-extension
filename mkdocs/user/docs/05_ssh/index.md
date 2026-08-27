# 5. SSH 키 관리

> 가상 머신(VM)의 보안 접속을 위한 SSH 키 관리

---

## SSH 키 개요

SSH(Secure Shell Protocol)는 네트워크를 통한 안전한 원격 접속을 제공합니다.
Infinitystack에 SSH 공개키를 등록하면 VM 생성 시 자동으로 주입되어 키 기반 인증으로 접속할 수 있습니다.

```
[사용자 로컬 PC]  ←── SSH 키 인증 ───→  [Infinitystack VM]
  (Private Key)                          (Public Key 주입됨)
```

---

## STEP 1. SSH 키 새로 만들기

로컬 터미널에서 새 SSH 키 쌍을 생성합니다.

```bash
ssh-keygen -t rsa -b 4096 -C "infinitystack@bground.ai"
```

**생성 과정:**
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa):  # Enter
Enter passphrase (empty for no passphrase):                       # Enter
Enter same passphrase again:                                      # Enter

Your identification has been saved in /home/ubuntu/.ssh/id_rsa
Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub
```

!!! info "저장 위치"
    기본값: `/home/your_user/.ssh/id_rsa` (또는 `~/.ssh/id_rsa`)

    사용자 지정: `$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

---

## STEP 2. 키 내용 확인

```bash
# Private Key 확인
cat ~/.ssh/id_rsa

# Public Key 확인 (Infinitystack에 등록할 값)
cat ~/.ssh/id_rsa.pub
```

---

## STEP 3. Infinitystack에 SSH 키 등록

**경로:** 고급 → **SSH 키** → **생성** 버튼

| 항목 | 입력값 |
|------|--------|
| **네임스페이스** | `default` |
| **이름** | `default-key` |
| **SSH 키 (공개키)** | `cat ~/.ssh/id_rsa.pub` 출력값 전체 붙여넣기 |

!!! warning "Public Key 입력"
    `*ssh rsa public*` 값을 입력합니다.
    반드시 `id_rsa.pub` (공개키) 내용을 입력하고, `id_rsa` (개인키)는 절대 공유하지 마세요.

**생성** 버튼 클릭

---

## STEP 4. VM에서 SSH 키 사용

VM 생성 시 **기본 정보** → **SSH 키** 항목에서 등록한 키를 선택합니다.

VM 생성 완료 후 접속:
```bash
ssh -i ~/.ssh/id_rsa ubuntu@<VM_IP>
```
