# DoTodo Backend

> 음성으로 할 일을 관리하는 스마트 TODO 앱 백엔드

## 📋 프로젝트 개요

**DoTodo**는 음성 입력을 AI로 분석하여 구조화된 할 일 목록을 생성하고, 사용자 패턴을 학습하여 맞춤형 추천을 제공하는 서비스입니다.

```
iOS 앱 (STT) → FastAPI 백엔드 → AI 모델 서버 → PostgreSQL
                    ↓
              Airflow + dbt + Dashboard
```

## 🏗️ 아키텍처

### 주요 컴포넌트

- **FastAPI Server**: REST API 제공 및 모델 서버 프록시
- **PostgreSQL**: 사용자 데이터 및 할 일 저장소
- **Airflow**: 데이터 동기화 및 배치 작업 스케줄링
- **dbt**: 데이터 변환 및 분석 모델링
- **Streamlit Dashboard**: 실시간 데이터 모니터링

## 🚀 빠른 시작

### 사전 요구사항

- Docker & Docker Compose
- Git

### 설치 및 실행

```bash
# 1. 저장소 클론
git clone <repository-url>
cd dotodo_backend

# 2. 환경 변수 설정
cp .env.example .env
# .env 파일을 열어 필요한 값 설정

# 3. Docker Compose로 전체 스택 실행
docker-compose up --build

# 4. 서비스 확인
# - FastAPI: http://localhost:8000
# - API 문서: http://localhost:8000/docs
# - Airflow: http://localhost:8080 (admin/admin)
# - Dashboard: http://localhost:8501
```

## 📁 프로젝트 구조

```
dotodo_backend/
├── backend/                 # FastAPI 백엔드
│   ├── app/
│   │   ├── main.py         # 앱 진입점
│   │   ├── routers/        # API 엔드포인트
│   │   ├── core/           # 설정 및 DB 연결
│   │   ├── models.py       # SQLAlchemy 모델
│   │   └── schemas.py      # Pydantic 스키마
│   └── Dockerfile
├── airflow/                 # Airflow DAGs
│   └── dags/
│       ├── data_sync_dag.py
│       └── metrics_update_dag.py
├── dbt/                     # dbt 프로젝트
│   ├── models/
│   │   ├── user_activity_model.sql
│   │   └── recommendation_stats.sql
│   └── profiles.yml
├── dashboard/               # Streamlit 대시보드
│   └── app.py
└── docker-compose.yaml      # 전체 스택 구성
```

## 🔌 API 엔드포인트

### 1. 음성 텍스트 파싱

```http
POST /api/todos
Content-Type: application/json

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

### 2. 맞춤형 추천 생성

```http
POST /api/recommendations
Content-Type: application/json

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

### 3. 헬스 체크

```http
GET /health
```

**응답:**
```json
{
  "status": "ok",
  "database": "healthy",
  "message": "DoTodo API is running!"
}
```

## 🗄️ 데이터베이스 스키마

### todos 테이블
```sql
CREATE TABLE todos (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR NOT NULL,
    task VARCHAR NOT NULL,
    category VARCHAR,
    completed BOOLEAN DEFAULT FALSE,
    source VARCHAR,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### recommendations 테이블
```sql
CREATE TABLE recommendations (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR NOT NULL,
    recommended_task VARCHAR,
    category VARCHAR,
    reason TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);
```

## ⚙️ 환경 변수

`.env` 파일에 다음 변수를 설정하세요:

```env
# Database
DATABASE_URL=postgresql://postgres:postgres@db:5432/dotodo

# Model Server URLs
MODEL_PARSE_URL=http://model-server:8001/parse
MODEL_RECO_URL=http://model-server:8002/recommend

# Airflow
AIRFLOW_UID=50000
AIRFLOW__CORE__EXECUTOR=LocalExecutor
AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=postgresql+psycopg2://postgres:postgres@db:5432/airflow
```

## 🧪 테스트

```bash
# API 테스트
curl http://localhost:8000/health
```

## 📊 모니터링

- **Airflow UI**: http://localhost:8080 - DAG 실행 상태 모니터링
- **Dashboard**: http://localhost:8501 - 실시간 데이터 대시보드
- **API Docs**: http://localhost:8000/docs - Swagger UI



# Airflow - Data Pipeline Orchestration

> DoTodo 데이터 파이프라인 스케줄링 및 워크플로우 관리

## 📋 개요

Apache Airflow를 사용하여 데이터 동기화, 분석, 집계 작업을 자동화합니다.

## 🏗️ 프로젝트 구조

```
airflow/
├── dags/
│   ├── data_sync_dag.py           # 데이터 동기화 DAG
│   ├── metrics_update_dag.py      # 지표 업데이트 DAG
│   └── dotodo_analytics.py        # 일일 분석 DAG
├── plugins/                        # 커스텀 플러그인 (예정)
└── logs/                          # 실행 로그 (자동 생성)
```

## 📅 DAG 목록

### 1. data_sync_dag
**목적**: 모바일 앱에서 업로드된 데이터 동기화

**스케줄**: 매시간 (0분)
```python
schedule='0 * * * *'  # Every hour at minute 0
```

**태스크:**
- `fetch_pending_data`: DB에서 동기화 대기 중인 데이터 조회
- `validate_data`: 데이터 유효성 검증
- `sync_to_warehouse`: 데이터 웨어하우스로 전송
- `mark_as_synced`: 동기화 완료 표시

### 2. metrics_update_dag
**목적**: 사용자별 KPI 및 지표 계산

**스케줄**: 매일 새벽 2시
```python
schedule='0 2 * * *'  # Daily at 2:00 AM
```

**태스크:**
- `calculate_completion_rate`: 완료율 계산
- `calculate_streak`: 연속 달성 일수 계산
- `update_category_stats`: 카테고리별 통계 업데이트
- `save_metrics`: 계산된 지표 DB 저장

### 3. dotodo_analytics
**목적**: 일일 데이터 분석 파이프라인

**스케줄**: 매일 새벽 1시
```python
schedule='0 1 * * *'  # Daily at 1:00 AM
```

**태스크:**
- `create_analytics_table`: 분석 테이블 생성
- `extract_user_activity`: 사용자 활동 추출
- `calculate_completion_rates`: 완료율 계산
- `analyze_category_trends`: 카테고리 트렌드 분석
- `detect_user_patterns`: 사용자 패턴 감지
- `generate_daily_summary`: 일일 요약 생성
- `save_analytics_results`: 분석 결과 저장

## 🚀 사용 방법

### Airflow UI 접속
```
http://localhost:8080
Username: admin
Password: admin
```

### DAG 수동 실행
1. Airflow UI에서 DAG 선택
2. 우측 상단 "Trigger DAG" 버튼 클릭
3. 실행 파라미터 입력 (선택사항)

### CLI로 DAG 실행
```bash
# 특정 DAG 실행
docker-compose exec airflow-scheduler airflow dags trigger data_sync_dag

# DAG 목록 확인
docker-compose exec airflow-scheduler airflow dags list

# DAG 상태 확인
docker-compose exec airflow-scheduler airflow dags state data_sync_dag
```

## 🔧 새 DAG 추가하기

1. **DAG 파일 생성**
   ```bash
   touch airflow/dags/new_pipeline.py
   ```

2. **DAG 정의**
   ```python
   from datetime import datetime, timedelta
   from airflow import DAG
   from airflow.operators.python import PythonOperator
   
   default_args = {
       'owner': 'dotodo-team',
       'depends_on_past': False,
       'start_date': datetime(2025, 1, 1),
       'email_on_failure': False,
       'email_on_retry': False,
       'retries': 1,
       'retry_delay': timedelta(minutes=5),
   }
   
   dag = DAG(
       'new_pipeline',
       default_args=default_args,
       description='새로운 파이프라인',
       schedule='0 3 * * *',  # 매일 3시
       catchup=False,
       tags=['dotodo', 'custom']
   )
   
   def my_task():
       print("Task executed!")
   
   task1 = PythonOperator(
       task_id='task1',
       python_callable=my_task,
       dag=dag
   )
   ```

3. **DAG 검증**
   ```bash
   docker-compose exec airflow-scheduler airflow dags test new_pipeline
   ```

## ⚙️ 환경 변수

Airflow 설정은 `docker-compose.yaml`에서 관리:

```yaml
environment:
  AIRFLOW__CORE__EXECUTOR: LocalExecutor
  AIRFLOW__DATABASE__SQL_ALCHEMY_CONN: postgresql+psycopg2://postgres:postgres@db:5432/airflow
  AIRFLOW__CORE__FERNET_KEY: 'your-fernet-key'
  AIRFLOW__WEBSERVER__SECRET_KEY: 'your-secret-key'
```

## 📊 모니터링

### DAG 실행 상태 확인
- **Airflow UI > DAGs**: 모든 DAG 상태 한눈에 확인
- **Airflow UI > Browse > Task Instances**: 개별 태스크 실행 이력
- **Airflow UI > Browse > DAG Runs**: DAG 실행 이력

### 로그 확인
```bash
# DAG 로그 확인
docker-compose exec airflow-scheduler tail -f /opt/airflow/logs/scheduler/latest/*.log

# 특정 태스크 로그
docker-compose logs airflow-scheduler | grep "task_id"
```

## 🔗 데이터베이스 연결

PostgreSQL 연결 설정:

```python
from airflow.providers.postgres.hooks.postgres import PostgresHook

def my_postgres_task():
    hook = PostgresHook(postgres_conn_id='postgres_default')
    conn = hook.get_conn()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM todos LIMIT 10")
    return cursor.fetchall()
```

**Connection 추가 방법:**
1. Airflow UI > Admin > Connections
2. "+" 버튼 클릭
3. Connection 정보 입력:
   - Conn Id: `postgres_default`
   - Conn Type: `Postgres`
   - Host: `db`
   - Schema: `dotodo`
   - Login: `postgres`
   - Password: `postgres`
   - Port: `5432`

## 🧪 테스트

```bash
# DAG 문법 체크
docker-compose exec airflow-scheduler python /opt/airflow/dags/data_sync_dag.py

# 특정 태스크 테스트
docker-compose exec airflow-scheduler airflow tasks test data_sync_dag fetch_pending_data 2025-09-29
```

## 📦 주요 컴포넌트

- **Scheduler**: DAG 스케줄링 및 태스크 실행 관리
- **Webserver**: UI 제공
- **Executor**: LocalExecutor (단일 서버 환경)
- **Database**: PostgreSQL (메타데이터 저장)

## 💡 Best Practices

1. **Idempotency**: 동일한 입력으로 여러 번 실행해도 결과가 같도록 설계
2. **Catchup**: `catchup=False`로 과거 실행 방지
3. **Retry Logic**: 실패 시 재시도 횟수 및 간격 설정
4. **Timeout**: 장시간 실행 태스크에 timeout 설정
5. **태그 활용**: DAG 그룹화 및 필터링용 태그 추가