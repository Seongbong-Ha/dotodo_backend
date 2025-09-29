# Backend - FastAPI Server

> DoTodo 백엔드 API 서버

## 📋 개요

FastAPI 기반의 RESTful API 서버로, 모바일 클라이언트와 AI 모델 서버 사이의 프록시 역할을 수행합니다.

## 🏗️ 프로젝트 구조

```
backend/
├── app/
│   ├── main.py              # FastAPI 앱 진입점
│   ├── routers/             # API 엔드포인트
│   │   ├── todos.py         # 할일 파싱 및 완료 처리
│   │   ├── recommendations.py  # 추천 생성
│   │   └── health.py        # 헬스 체크
│   ├── core/                # 핵심 설정
│   │   ├── config.py        # 환경 변수 관리
│   │   └── database.py      # DB 연결 설정
│   ├── models.py            # SQLAlchemy 모델 (DB 테이블)
│   ├── schemas.py           # Pydantic 스키마 (요청/응답)
│   └── services/            # 외부 API 어댑터
├── Dockerfile
└── requirements.txt
```

## 🔌 API 엔드포인트

### 1. POST /api/todos
음성 텍스트를 할 일 목록으로 파싱

**요청:**
```json
{
  "user_id": "user001",
  "text": "오늘 방 청소하고 빨래해야해"
}
```

**응답:**
```json
{
  "success": true,
  "todos": [
    {
      "user_id": "user001",
      "todo": "방 청소하기",
      "date": "2025-09-29",
      "time": "",
      "category": "집안일",
      "original_sentence": "오늘 방 청소하고",
      "embedding": [0.1, 0.2, ...]
    }
  ]
}
```

### 2. POST /api/recommendations
사용자별 맞춤 추천 생성

**요청:**
```json
{
  "user_id": "user001",
  "base_date": "2025-09-29"
}
```

**응답:**
```json
{
  "user_id": "user001",
  "date": "2025-09-29",
  "recommendations": [
    {
      "category": "운동",
      "task": "스트레칭하기",
      "completed": false
    }
  ],
  "reason": "과거 패턴을 보면 운동을 꾸준히 하시는 편이에요."
}
```

### 3. GET /health
서버 및 DB 상태 확인

**응답:**
```json
{
  "status": "ok",
  "database": "healthy",
  "message": "DoTodo API is running!"
}
```

## 🚀 로컬 개발

### Docker 사용 (권장)
```bash
# 루트 디렉토리에서
docker-compose up backend
```

### 직접 실행
```bash
cd backend

# 가상환경 생성
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 의존성 설치
pip install -r requirements.txt

# 서버 실행
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

서버 실행 후:
- API: http://localhost:8000
- Swagger 문서: http://localhost:8000/docs
- ReDoc 문서: http://localhost:8000/redoc

## 🗄️ 데이터베이스

### SQLAlchemy 모델

**todos 테이블:**
```python
class Todo(Base):
    id: int (PK)
    user_id: str
    task: str
    category: str
    completed: bool
    source: str  # 'voice_parsing', 'recommendation' 등
    created_at: datetime
    updated_at: datetime
```

**recommendations 테이블:**
```python
class Recommendation(Base):
    id: int (PK)
    user_id: str
    recommended_task: str
    category: str
    reason: str
    created_at: datetime
```

## ⚙️ 환경 변수

`.env` 파일에 설정:

```env
# Database
DATABASE_URL=postgresql://postgres:postgres@db:5432/dotodo

# Model Server URLs
MODEL_PARSE_URL=http://model-server:8001/parse
MODEL_RECO_URL=http://model-server:8002/recommend

# App Settings
DEBUG=true
LOG_LEVEL=debug
```

## 🔧 새 엔드포인트 추가하기

1. **라우터 파일 생성**
   ```bash
   touch app/routers/new_feature.py
   ```

2. **라우터 작성**
   ```python
   from fastapi import APIRouter, Depends
   from sqlalchemy.orm import Session
   from ..core.database import get_db
   
   router = APIRouter(prefix="/api", tags=["new_feature"])
   
   @router.get("/new-endpoint")
   def new_endpoint(db: Session = Depends(get_db)):
       return {"message": "New endpoint"}
   ```

3. **main.py에 등록**
   ```python
   from .routers import new_feature
   app.include_router(new_feature.router)
   ```

## 🧪 테스트

```bash
# API 테스트
curl http://localhost:8000/health

# Swagger UI에서 대화형 테스트
# http://localhost:8000/docs
```

## 📦 주요 의존성

- **FastAPI**: 웹 프레임워크
- **Uvicorn**: ASGI 서버
- **SQLAlchemy**: ORM
- **Pydantic**: 데이터 검증
- **httpx**: 비동기 HTTP 클라이언트 (모델 서버 통신)
- **psycopg2**: PostgreSQL 드라이버