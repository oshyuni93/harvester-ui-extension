# 8. 로드밸런서 관리

> 가상 머신(VM)의 로드밸런스 제공

---

## 개요

Infinitystack의 로드밸런서는 **Mgmt Network (VLAN100)** 기반으로 외부 트래픽을 여러 VM으로 분산합니다.

```
연결망 (외부)
     ↓
  Infinitystack
  ┌──────────────────────────┐
  │   Mgmt Network (VLAN100) │
  │                          │
  │   ┌──────────────────┐   │
  │   │   로드밸런서      │   │
  │   └──────┬───────────┘   │
  │          ├──→ VM1        │
  │          ├──→ VM2        │
  │          └──→ VM3        │
  │      management Network  │
  └──────────────────────────┘
```

!!! info "Management Network IP 대역"
    Infinistack 내부의 Reserved된 IP 대역: `10.x.x.x`

---

## 이 챕터에서 다루는 내용

| 페이지 | 내용 |
|--------|------|
| [IP 풀 구성](ip_pool.md) | 로드밸런서용 IP 풀 생성 |
| [로드밸런서 생성](create.md) | 리스너 및 백앤드 서버 설정 |
