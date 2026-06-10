# 과제 3: 청크 기반 대용량 업로드 (Resumable Upload)

수 GB 파일을 청크 단위로 쪼개고, 브라우저 새로고침 후에도 재개되는 업로드 시스템을 구현하세요.

## 핵심 요구사항

### 1. 청크 업로드

- 기본 청크 크기: 5MB
- 각 청크 독립 업로드
- 업로드 중단/재개 가능
- **동시 업로드 개수 제한**: 하나의 파일을 청크로 나눠서 **동시에 3개 청크까지** 업로드
  - 예: 100MB 파일 → 20개 청크(5MB씩) → 3개씩 병렬 업로드
  - 청크 1, 2, 3 → 동시 업로드
  - 청크 1 완료 → 청크 4 시작

### 2. Resumable Upload

- localStorage 또는 IndexedDB 사용
- 한 번 업로드된 청크는 다시 업로드하지 않음
- 새로고침 후에도 복원
- Mock API에서 기존 업로드 상태 반환

### 3. 에러 처리

- 청크 단위 자동 재시도
- exponential backoff (1s → 2s → 4s)
- 일부 청크 실패해도 전체 업로드는 계속

## Mock API (필수)

백엔드가 있어야 구현 가능한 기능이므로 Mocking 기술을 반드시 사용해야 합니다.

**권장 도구: MSW (Mock Service Worker)**

### 제공해야 하는 엔드포인트

```
POST /api/upload/init
POST /api/upload/chunk
GET /api/upload/status/:uploadId
POST /api/upload/complete
```

### Mock API 요구사항

- 청크 업로드 시 100~500ms 랜덤 지연
- 10~20% 오류 발생 확률
- 업로드 상태 저장
- 네트워크 시나리오를 최대한 현실적으로 재현

### Mock API 상태 관리 방법

MSW는 브라우저 새로고침 시 상태가 사라집니다.
따라서 **MSW 핸들러 내부에서도 localStorage/IndexedDB**를 사용하여 업로드 상태를 저장하세요:

```typescript
// MSW handler 예시
import { http, HttpResponse } from 'msw';

export const handlers = [
  http.post('/api/upload/chunk', async ({ request }) => {
    const formData = await request.formData();
    const uploadId = formData.get('uploadId') as string;
    const chunkIndex = formData.get('chunkIndex') as string;

    // localStorage에 청크 업로드 상태 저장
    const savedState = JSON.parse(
      localStorage.getItem(`upload_${uploadId}`) || '{}'
    );
    savedState.chunks = savedState.chunks || {};
    savedState.chunks[chunkIndex] = { uploaded: true, timestamp: Date.now() };
    localStorage.setItem(`upload_${uploadId}`, JSON.stringify(savedState));

    return HttpResponse.json({ success: true });
  }),

  http.get('/api/upload/status/:uploadId', ({ params }) => {
    const savedState = localStorage.getItem(`upload_${params.uploadId}`);
    return HttpResponse.json(JSON.parse(savedState || '{}'));
  })
];
```

이렇게 하면 새로고침 후에도 Mock API가 기존 상태를 반환할 수 있습니다.

### 테스트 파일 생성

실제 GB 파일을 업로드할 필요는 없습니다. Mock 파일 객체를 생성하여 테스트하세요:

```typescript
// Mock 파일 생성 함수
const createMockFile = (sizeMB: number, name: string) => {
  return new File(
    [new ArrayBuffer(sizeMB * 1024 * 1024)],
    name,
    { type: 'application/octet-stream' }
  );
};

// 100MB 테스트 파일 생성
const testFile = createMockFile(100, 'large-file.bin');
```

**권장 테스트 시나리오:**
- 50MB 파일: 10개 청크 (기본 동작 확인)
- 100MB 파일: 20개 청크 (병렬 업로드 확인)
- 200MB 파일: 40개 청크 (새로고침 재개 확인)

## 기술 스택

- React + TypeScript
- 상태 관리 (Zustand / Recoil / Redux / Jotai 중 자유 선택)
- Mocking: MSW 권장, 대체 mocking 기술 허용
- 저장소: localStorage 또는 IndexedDB

## 평가 기준

- 파일이 청크 단위로 분할되어 업로드되는가?
- 브라우저 새로고침 후 업로드가 재개되는가?
- 업로드된 청크는 다시 업로드하지 않는가?
- 청크 실패 시 exponential backoff로 재시도하는가?
- Mock API가 실제 백엔드처럼 동작하는가?
- TypeScript를 활용한 타입 안정성
- 에러 처리 및 복구 메커니즘
- 코드 구조와 가독성
- 사용자 경험(UX)
