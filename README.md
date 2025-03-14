# SnapTrip - 즉흥적이고 편안한 여행 앱

SnapTrip은 즉흥적이고 편안한 여행을 위해 직관적인 인터페이스를 제공하는 여행 앱입니다.

## 주요 기능

### 1. 인증 시스템

- 이메일/비밀번호 로그인 및 회원가입
- 사용자 프로필 관리

### 2. 홈 화면

- 하단 네비게이션 바로 4개의 주요 탭 탐색
  - 둘러보기: 추천 여행 및 인기 목적지 표시
  - 내 여행: 사용자의 예정된 여행과 지난 여행 목록
  - 알림: 여행 관련 알림 및 메시지
  - 프로필: 사용자 프로필 및 설정

### 3. 백엔드 통합

- Supabase 백엔드 연동으로 데이터 저장 및 사용자 인증
- 실시간 데이터 업데이트 지원

## 기술 스택

- **프론트엔드**: Flutter (Dart)
- **백엔드**: Supabase
- **인증**: Supabase Auth
- **데이터베이스**: PostgreSQL (Supabase)
- **스토리지**: Supabase Storage

## 설정 방법

### 필수 요구사항

- Flutter SDK (최신 버전)
- Dart SDK (최신 버전)
- Android Studio 또는 VS Code
- Supabase 계정

## 진행 상황

- [x] 프로젝트 구조 설정
- [x] Supabase 백엔드 통합
- [x] 사용자 인증 구현 (로그인, 회원가입, 비밀번호 재설정)
- [x] 기본 UI 프레임워크 구현
- [x] 홈 화면 탭 구현 (둘러보기, 내 여행, 알림, 프로필)
- [ ] 카카오맵 연동
- [ ] 여행 추천 알고리즘
- [ ] 그룹 여행 기능
- [ ] 경비 관리 기능
- [ ] 오프라인 지도 및 데이터 캐싱
