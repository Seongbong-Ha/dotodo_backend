## 백엔드 개발 공간입니다.

## 개발 환경 선택

### Option 1: Docker (권장)
docker-compose up --build
종료
docker-compose up --build

### Option 2: 로컬 환경
1. PostgreSQL 설치
2. backend/에서 pip install -r requirements.txt
3. uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
