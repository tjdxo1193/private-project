# 과제 1: 멀티 파일 업로드 큐 시스템

여러 개의 파일을 순차적으로 업로드하는 업로드 큐 시스템(UI + 로직)을 구현합니다.

## 요구사항 요약

### 1. 파일 선택 & 대기열 관리

- 여러 파일 선택 가능
- 드래그앤 드롭으로 파일 업로드 가능
- 폴더 업로드 처리 가능 (폴더 내 파일을 모두 대기열에 추가)
- 대기열 UI 표시 (이름, 크기, 상태)
- 상태 종류: `pending`, `uploading`, `paused`, `completed`, `failed`, `cancelled`

### 2. 업로드 처리

- 한 번에 하나씩 순차 업로드
- 진행률, 속도(MB/s), 예상 시간 표시
- 자동으로 다음 파일 업로드
- 개별 취소 & 전체 취소
- 개별 일시정지 / 재개
- 네트워크 오류 발생 시 자동 재시도(최대 3회)

### 3. Mock API (필수)

백엔드 API가 필요하므로 반드시 Mocking 기술을 사용해야 합니다.

**Mock API 엔드포인트:**

```typescript
POST /api/upload
  Body: FormData with file
  Response: {
    id: string,
    fileName: string,
    fileSize: number,
    progress: number,
    status: 'pending' | 'uploading' | 'paused' | 'completed' | 'failed'
  }

DELETE /api/upload/:id
  Response: { success: boolean }

POST /api/upload/:id/pause
  Response: { success: boolean, status: 'paused' }

POST /api/upload/:id/resume
  Response: { success: boolean, status: 'uploading' }
```

**Mock API 기능 가이드:**

- 업로드 지연(랜덤 100~200ms per MB)
- 속도 변동 시뮬레이션
- 10% 확률 네트워크 오류
- 일시정지/취소/재개 상태 반영

### 4. 재시도 정책

- 실패 시 **exponential backoff**: 1초 → 2초 → 4초 간격으로 재시도
- 3회 실패 후 `failed` 상태로 전환
- 사용자는 실패한 파일을 수동으로 재시도할 수 있음

### 5. 테스트 파일 가이드

- 다양한 크기의 파일로 테스트 (1MB ~ 100MB 권장)
- 속도와 진행률이 눈에 보이도록 **10MB 이상 파일 포함**
- 실제 파일을 사용하거나 Mock 파일 객체 생성:

```typescript
// Mock 파일 생성 예시
const createMockFile = (sizeMB: number, name: string) => {
  return new File(
    [new ArrayBuffer(sizeMB * 1024 * 1024)],
    name,
    { type: 'application/octet-stream' }
  );
};

const testFile = createMockFile(50, 'test-50mb.bin');
```

## 기술 스택

- React + TypeScript
- 상태 관리 (Zustand / Recoil / Redux / Jotai 중 자유 선택)
- Mocking: MSW 권장, 대체 mocking 기술 허용

## 평가 기준

- 순차적 업로드 큐 관리가 정상 동작하는가?
- 개별 파일의 취소/일시정지/재개가 잘 동작하는가?
- 진행률, 속도, 예상 시간이 정확하게 표시되는가?
- 네트워크 오류 시 자동 재시도가 동작하는가?
- Mock API가 실제 백엔드처럼 동작하는가?
- TypeScript를 활용한 타입 안정성
- 코드 구조와 가독성
- 사용자 경험(UX)
