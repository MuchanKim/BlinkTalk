# .github-template
> GitHub 레포지토리의 이슈/PR 템플릿 및 설정을 위한 표준 템플릿입니다. 자유롭게 사용 가능합니다. - Moo -

[![마지막 업데이트](https://img.shields.io/badge/last%20updated-2025--01--05-brightgreen)](https://github.com/username/github-template/commits/main)

## 📌 주요 기능

### 1. 이슈 템플릿
- ❌ 버그 리포트 (`bug_report.md`)
- ✨ 기능 제안 (`feature_request.md`)
- 📋 일반 이슈 (`general_issue.md`)

### 2. PR 템플릿
- PR 타입 지정
- 작업 내용 설명
- 리뷰어 체크리스트

### 3. 브랜치 전략
```
main (배포)
├── hotfix/* (긴급 수정)
└── develop (개발)
    ├── feature/* (기능 개발)
    ├── release/* (배포 준비)
    └── ...
```

#### 브랜치 설명
| 브랜치 | 설명 |
|--------|------|
| `main` | 제품 출시/배포용 브랜치 |
| `hotfix/*` | 출시 버전의 긴급 수정 브랜치 |
| `release/*` | 다음 출시 버전 준비 브랜치 |
| `develop` | 다음 출시 버전 개발 브랜치 |
| `feature/*` | 기능 개발 브랜치 |

#### 작업 프로세스
1. `feature/*` 브랜치는 `develop`에서 분기
2. 기능 개발 완료 후 `develop`으로 병합
3. 배포 준비가 되면 `develop`에서 `release/*` 분기
4. 테스트 후 `master`와 `develop`으로 병합
5. 출시 버전에서 버그 발생 시 `master`에서 `hotfix/*` 분기
6. 수정 후 `master`와 `develop`에 병합

#### 네이밍 규칙
| 브랜치 | 네이밍 예시 |
|--------|------------|
| `feature/*` | feature/login |
| `release/*` | release/v1.0.0 |
| `hotfix/*` | hotfix/v1.0.1 |


### 4. 레이블 설정
| 레이블 | 설명 | 색상 |
|--------|------|------|
| `Bug` | 버그 수정 | `#d73a4a` |
| `Feature` | 새로운 기능 | `#a2eeef` |
| `Chore` | 환경 설정 | `#0075ca` |
| `Docs` | 문서 작업 | `#0e8a16` |
| `♻Refactor` | 코드 개선 | `#1d76db` |
| `Style` | UI/UX 변경 | `#fef2c0` |
| `Question` | 질문/논의 | `#d876e3` |
| `High` | 높은 우선순위 | `#b60205` |
| `Medium` | 중간 우선순위 | `#d876e3` |
| `Low` | 낮은 우선순위 | `#67e2ae` |
| `Blocked` | 작업 중단 | `#e99695` |

## 🛠️ Git 설정

### .gitignore
Swift/Xcode 프로젝트에 최적화된 `.gitignore` 설정이 포함되어 있습니다:
- Xcode 사용자 설정 파일
- 빌드 결과물
- 의존성 관리 파일
- 시스템 파일
- 등...

자세한 내용은 [.gitignore](.gitignore) 파일을 참고해주세요.

### .gitattributes
프로젝트 파일의 충돌을 방지하기 위한 설정이 포함되어 있습니다:

## 🚀 시작하기

### 사용 방법
1. 이 템플릿을 사용하여 새 레포지토리 생성
   ```bash
   gh repo create [레포지토리명] --template [이 템플릿 URL]
   ```
   또는 GitHub에서 "Use this template" 버튼 클릭

2. 브랜치 보호 규칙 설정
   - `main`, `develop` 브랜치 보호
   - PR 필수
   - 리뷰 승인 필수

3. 프로젝트에 맞게 템플릿 수정
   - 이슈 템플릿 커스터마이징
   - PR 템플릿 수정
   - 브랜치 전략 조정

## ⚠️ 참고사항

이 템플릿은 GitHub 레포지토리 설정을 위한 참고용으로 제공됩니다.
- 이슈/PR 템플릿
- 브랜치 전략
- Git 설정 파일
- 레이블 설정
등을 자유롭게 참고하여 프로젝트에 맞게 수정해서 사용하실 수 있습니다.

단, 이 템플릿의 완성도나 정확성을 보장하지 않으며, 사용에 따른 책임은 사용자에게 있습니다.
