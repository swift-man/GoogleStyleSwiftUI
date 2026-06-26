# AGENTS.md

## Project Architecture (SOLID)

### Single Responsibility
- 공개 API는 `Sources/GoogleStyleSwiftUI/Public` 에서만 관리한다.
- 동작 보조 코드, 스타일 유틸리티, 내부 래퍼는 `Sources/GoogleStyleSwiftUI/Private`로 분리한다.
- 테스트 코드는 `Tests/GoogleStyleSwiftUITests`에서만 관리한다.

### Open/Closed
- 공개 API의 시그니처는 하위 호환을 유지하면서 확장 가능하도록 설계한다.
- 플랫폼·빌드·테스트 요구가 바뀌면 `.reviewbot.yml`의 리뷰 범위 규칙만 갱신한다.

### Liskov Substitution
- 공용 API는 내부 구현 변경 없이 동일 동작을 보장해야 한다.
- 제한 동작(문자 길이)은 공용 뷰(`GSTextField`, `GSSecureField`)와 내부 유틸(`GSLimitPolicy`)에서 단일 정책으로 통일한다.

### Interface Segregation
- 리뷰 대상은 다음 3개 레이어로 분리한다.
  - `Always Review`: 핵심 API/설정
  - `include`: 기본 리뷰 대상
  - `exclude`: 리뷰 제외 항목
- 공개 API는 `Public`, 내부 구현은 `Private`로 구분한다.

### Dependency Inversion
- 외부 라이브러리(`LimitLengthTextField`)는 `Private`에서만 직접 참조하고,
  공개 API는 자체 뷰 컴포넌트로만 노출한다.

## SPM 기준 리뷰 예외/대상

### Never Review
- `Package.resolved` 내부 캐시 항목은 리뷰 대상에서 제외
- `.DS_Store`, `**/.DS_Store`
- `.idea/**`, `.vscode/**`, `**/*.xcuserstate`, `**/xcuserdata/**`
- `.build/**`, `.swiftpm/**`, `build/**`, `Packages/**`, `DerivedData/**`
- `GoogleStyleUI/**/*.xcodeproj/**`, `GoogleStyleUI/**/*.xcworkspace/**`
- `logs/**`, `**/*.log`, `*.dSYM`, `*.dSYM.zip`, `*.xcarchive`

### Always Review
- `AGENTS.md`, `.reviewbot.yml`, `README.md`
- `Package.swift`, `Package.resolved`
- `Sources/GoogleStyleSwiftUI/Public/Color+.swift`
- `Sources/GoogleStyleSwiftUI/Public/GSTextField.swift`
- `Sources/GoogleStyleSwiftUI/Public/GSMultilineTextField.swift`
- `Sources/GoogleStyleSwiftUI/Public/GSTextView.swift`
- `Sources/GoogleStyleSwiftUI/Public/GSSecureField.swift`

## PR/Review Operations

- PR 제목은 `[Codex]`, `[codex]` 접두사를 사용하지 않는다.
- 타입 기반 접두사를 사용한다.
  - `feat.`, `fix.`, `docs.`, `chore.`, `env.` 등
- Draft PR는 생성하지 않고 Ready 상태로 생성한다.
- PR merge 후 브랜치를 삭제해서 정리한다.
- 리뷰 요청 시 열려 있는 PR의 댓글/대댓글을 확인하고, 수정 필요 이슈가 없으면 병합한다.
- 수정 필요가 있다면 반영 후 즉시 병합하지 않고 추가 코멘트 또는 리바이스를 기다린다.
- 코드 리뷰에서 지적이 실제 수정이 필요한지/환각인지 반드시 구분해 코멘트한다.
