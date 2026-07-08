## 개요

총 3개의 과제로 구성되어 있으며, 3문제를 모두 풀이하셔야 평가 대상이 됩니다.

## 백엔드가 필요한 기능은 반드시 "Mocking 기술"을 활용해 구현해야 합니다

이 과제를 수행하는 동안 실제 백엔드 API 서버는 제공되지 않습니다.

따라서 필요한 모든 API 요청은 다음과 같은 방식으로 프론트엔드에서 Mocking 하여 개발해야 합니다.

### 권장 모킹 도구: MSW (Mock Service Worker)

- **Official Docs**: https://mswjs.io
- **GitHub**: https://github.com/mswjs/msw

React 기반 프로젝트에서 가장 실제 네트워크 요청에 가깝게 시뮬레이션할 수 있는 도구입니다.

요청/응답, 지연, 에러, 업로드 흐름 등 다양한 네트워크 시나리오를 구현할 수 있습니다.

### 다른 모킹 기술 사용 가능

MSW 사용을 권장하지만, MSW에 준하는 수준으로 API mocking, 요청/응답 시뮬레이션, 지연/에러 처리 등을 구현할 수 있다면 다른 방법을 사용해도 무방합니다.

**예시:**
- MirageJS
- 자체 작성한 fetch interceptor
- Axios interceptor 기반 mocking
- Browser mock server 구현 등

## AI 도구 활용 안내

과제는 AI 코딩 도구(ChatGPT, Cursor, Claude code, GitHub Copilot 등) 활용이 가능합니다.

AI 도구를 활용한 경우 각 과제의 README.md 에 어떤 도구를 활용했는지 명시해주셔야 합니다.

## 과제 안내

- 과제는 repo의 `task#-[문제]` 폴더 하단의 각 README.md를 확인해주세요. (총 3문제 입니다.)
- 과제 실행 방법은 본 문서(README.md)의 아래 양식에 맞춰서 본 문서를 업데이트 해주세요.
- 과제 관련 질문은 recruit@42tape.com으로 문의해주세요.

## 제출해야 할 구성 요소

### 1. 최종 결과물
- 사전에 안내된 GitHub repo (main 에 commit 하여 과제를 풀어주세요, 한번의 commit 으로 풀이하지 마시고. 문제를 해결한 과정을 commit 의 과정으로 남겨주세요.)
- 실행 화면 캡처 또는 배포된 링크 (선택사항입니다.)
- 로컬 실행 방법 안내 (본 README.md 문서 하단에 업데이트)

### 2. 과제 README 를 다음 내용이 포함되게 업데이트 해주세요.
- 문제를 어떻게 분석했는지
- 어떤 기술적 선택을 했는지 (라이브러리, 알고리즘 등)
- 최종 아키텍처 및 구조를 어떻게 결정했는지
- 개선하고 싶은 부분 (시간이 더 있었다면)
- 사용한 주요 도구 목록 (AI를 사용했다면 반드시 기록)

### 3. 설계 문서
- README 양식으로 작성할 수 없는 별도의 설계 문서가 있다면(UML 등) 자유 양식으로 추가 제출 가능합니다. (선택사항, git repo 에 포함하고 README 에 설명을 추가해주세요.)

## 로컬 실행 방법 (예시, 실제 방법으로 변경해주세요)
- Makefile 을 수정하여 make 커맨드로 실행가능하도록 작성해주세요.

- 과제1
```bash
# 의존성 설치
make install

# 과제1 실행
make run1
```
...

## 과제 repo 구조

```
42tape-frontend-assignment/
├── README.md              # 전체 과제 개요 및 실행 방법
├── Makefile               # 로컬 실행 방법 제공
├── task1-upload-queue/
│   ├── src/
│   ├── package.json
│   └── README.md          # 과제 1 문제
├── task2-file-list/
│   ├── src/
│   ├── package.json
│   └── README.md
└── task3-chunk-upload/
    ├── src/
    ├── package.json
    └── README.md
```

## 프로젝트 초기 설정 가이드

### 권장 방식
각 과제를 **독립적인 React 프로젝트**로 구성하세요.

### 초기 설정 예시 (Vite 사용)
```bash
# 과제 1 설정
cd task1-upload-queue
npm create vite@latest . -- --template react-ts
npm install

# 과제 2 설정
cd ../task2-file-list
npm create vite@latest . -- --template react-ts
npm install

# 과제 3 설정
cd ../task3-chunk-upload
npm create vite@latest . -- --template react-ts
npm install
```

### Makefile 설정
루트의 Makefile을 수정하여 각 과제를 쉽게 실행할 수 있도록 설정하세요.

```makefile
install:
	cd task1-upload-queue && npm install
	cd task2-file-list && npm install
	cd task3-chunk-upload && npm install

run1:
	cd task1-upload-queue && npm run dev

run2:
	cd task2-file-list && npm run dev

run3:
	cd task3-chunk-upload && npm run dev
```

## 기술 스택

- React 17+
- TypeScript 5+
- MSW (Mock Service Worker) 권장, 다른 Mocking 도구 사용 가능
- 빌드 도구: Vite 권장 (Create React App도 가능)
- 스타일링: 자유 (Tailwind CSS, Styled-Components, Emotion 등)
- 상태 관리: 자유 (Zustand, Recoil, Redux, Jotai 등)

## 과제 목록

### 과제 1: 멀티 파일 업로드 큐 시스템
여러 파일을 순차적으로 업로드하는 큐 시스템 구현
- **난이도**: 중
- **핵심 기술**: 상태 관리, MSW, 비동기 처리
- **상세 내용**: [task1-upload-queue/README.md](task1-upload-queue/README.md)

### 과제 2: 대용량 파일 목록 UI (5,000개 이상)
가상 스크롤을 활용한 대용량 파일 목록 렌더링
- **난이도**: 중상
- **핵심 기술**: Virtual Scroll, 성능 최적화, 트리 구조
- **상세 내용**: [task2-file-list/README.md](task2-file-list/README.md)

### 과제 3: 청크 기반 대용량 업로드 (Resumable)
재개 가능한(Resumable) 청크 업로드 구현
- **난이도**: 상
- **핵심 기술**: 파일 청크 분할, 영속화, MSW, 에러 복구
- **상세 내용**: [task3-chunk-upload/README.md](task3-chunk-upload/README.md)

## 개발 가이드

### UI/UX 참고 사항
- Google Drive, Dropbox 등의 파일 업로드/관리 UI 참고 가능
- **최소한의 기능 동작이 가장 중요**하며, 디자인 완성도는 평가 비중이 낮습니다
- 사용자가 현재 상태를 명확히 이해할 수 있도록 피드백 제공

### 테스트 코드
- 단위 테스트, E2E 테스트는 **선택사항**입니다
- 작성한 경우 가산점이 있습니다
- 테스트 프레임워크: Vitest, Jest, Testing Library 등 자유

### 성능 측정
- 과제 2의 경우 성능 측정 결과를 README.md에 포함하세요
- Chrome DevTools Performance 탭 또는 React DevTools Profiler 활용
- 측정 항목: 초기 렌더링 시간, 스크롤 FPS, 메모리 사용량 등

## 마지막 체크리스트

제출 전 다음 사항을 확인하세요:

- [ ] 모든 코드가 TypeScript로 작성되었나요?
- [ ] README에 로컬 실행 방법이 명확히 기재되어 있나요?
- [ ] 각 기술적 선택에 대한 이유가 설명되어 있나요?
- [ ] Mock API가 제대로 동작하나요?
- [ ] (과제 1) 여러 파일을 대기열에 추가하고 개별 취소가 가능한가요?
- [ ] (과제 2) 5,000개 이상의 항목이 부드럽게 스크롤되나요?
- [ ] (과제 3) 브라우저 새로고침 후 업로드가 재개되나요?
- [ ] 에러 상황에 대한 처리가 되어 있나요?
