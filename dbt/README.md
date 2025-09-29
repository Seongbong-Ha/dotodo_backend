# dbt - Data Transformation

> DoTodo 데이터 변환 및 분석 모델링

## 📋 개요

dbt (data build tool)를 사용하여 원천 데이터를 분석 가능한 형태로 변환하고 집계합니다.

## 🏗️ 프로젝트 구조

```
dbt/
├── models/
│   ├── staging/              # 원천 데이터 정제
│   │   ├── sources.yml      # 소스 테이블 정의
│   │   └── stg_todos.sql    # 할일 데이터 정제
│   └── marts/               # 분석용 집계 테이블
│       ├── daily_user_stats.sql      # 사용자별 일일 통계
│       └── category_summary.sql      # 카테고리별 요약
├── tests/                    # 데이터 품질 테스트
├── macros/                   # 재사용 가능한 SQL 함수
├── dbt_project.yml          # 프로젝트 설정
└── profiles.yml             # DB 연결 설정
```

## 📊 dbt 모델

### Staging Layer (정제)

#### stg_todos
원천 `todos` 테이블을 정제하고 정규화

**변환 내용:**
- user_id 형식 정규화 (`user001` → `user_001`)
- category NULL 처리 (`uncategorized`로 변환)
- created_date 컬럼 추가 (날짜만 추출)
- 필수 필드(user_id, task) NULL 제거

**예시:**
```sql
SELECT
    id,
    CASE 
        WHEN user_id LIKE 'user%' AND user_id NOT LIKE 'user_%'
        THEN CONCAT('user_', LPAD(...))
        ELSE user_id
    END AS user_id,
    COALESCE(category, 'uncategorized') AS category,
    created_at::DATE AS created_date
FROM {{ source('raw', 'todos') }}
```

### Marts Layer (집계)

#### daily_user_stats
사용자별 일일 활동 통계

**컬럼:**
- `user_id`: 사용자 ID
- `created_date`: 날짜
- `total_tasks`: 총 할일 수
- `completed_tasks`: 완료된 할일 수
- `incomplete_tasks`: 미완료 할일 수
- `completion_rate`: 완료율 (%)
- `categories_used`: 사용된 카테고리 수

**사용 예시:**
```sql
-- 특정 사용자의 최근 7일 통계
SELECT * FROM analytics.daily_user_stats
WHERE user_id = 'user_001'
  AND created_date >= CURRENT_DATE - 7
ORDER BY created_date DESC;
```

#### category_summary
카테고리별 전체 집계 통계

**컬럼:**
- `category`: 카테고리명
- `total_tasks`: 총 할일 수
- `completed_tasks`: 완료된 할일 수
- `completion_rate`: 완료율 (%)
- `unique_users`: 해당 카테고리 사용 유저 수
- `active_days`: 활동 일수

**사용 예시:**
```sql
-- 가장 많이 사용된 카테고리 TOP 5
SELECT * FROM analytics.category_summary
ORDER BY total_tasks DESC
LIMIT 5;
```

## 🚀 사용 방법

### dbt 명령어 실행

```bash
# dbt 컨테이너 진입
docker-compose exec dbt bash

# 모든 모델 실행
dbt run

# 특정 모델만 실행
dbt run --select stg_todos
dbt run --select daily_user_stats

# Staging 레이어만 실행
dbt run --select staging.*

# Marts 레이어만 실행
dbt run --select marts.*
```

### 테스트 실행

```bash
# 모든 테스트 실행
dbt test

# 특정 모델 테스트
dbt test --select stg_todos
```

### 문서 생성

```bash
# 문서 생성
dbt docs generate

# 문서 서버 실행 (로컬 환경)
dbt docs serve --port 8080
```

## ⚙️ 설정 파일

### dbt_project.yml
프로젝트 전체 설정

```yaml
name: 'dotodo_analytics'
version: '1.0.0'

models:
  dotodo_analytics:
    staging:
      +materialized: view       # View로 생성
      +schema: staging          # staging 스키마
    marts:
      +materialized: table      # Table로 생성
      +schema: marts            # marts 스키마
```

### profiles.yml
데이터베이스 연결 설정

```yaml
dotodo_analytics:
  target: dev
  outputs:
    dev:
      type: postgres
      host: db
      port: 5432
      user: postgres
      pass: postgres
      dbname: dotodo
      schema: analytics
      threads: 4
```

## 🔧 새 모델 추가하기

### 1. Staging 모델 추가

```bash
touch models/staging/stg_recommendations.sql
```

```sql
-- models/staging/stg_recommendations.sql
WITH source AS (
    SELECT * FROM {{ source('raw', 'recommendations') }}
)

SELECT
    id,
    user_id,
    recommended_task AS task,
    category,
    created_at::DATE AS created_date
FROM source
WHERE user_id IS NOT NULL
```

### 2. Mart 모델 추가

```bash
touch models/marts/weekly_summary.sql
```

```sql
-- models/marts/weekly_summary.sql
WITH base AS (
    SELECT * FROM {{ ref('stg_todos') }}
)

SELECT
    user_id,
    DATE_TRUNC('week', created_date) AS week_start,
    COUNT(*) AS total_tasks,
    COUNT(CASE WHEN completed THEN 1 END) AS completed_tasks
FROM base
GROUP BY user_id, DATE_TRUNC('week', created_date)
```

### 3. 모델 실행

```bash
dbt run --select +weekly_summary
```

## 📋 소스 정의

`models/staging/sources.yml`에서 원천 테이블 정의:

```yaml
version: 2

sources:
  - name: raw
    description: "DoTodo 앱 원천 데이터"
    database: dotodo
    schema: public
    tables:
      - name: todos
        description: "사용자 할일 테이블"
        columns:
          - name: id
            description: "할일 고유 ID"
            tests:
              - unique
              - not_null
```

## 🧪 테스트 작성

### Schema 테스트 (sources.yml)

```yaml
columns:
  - name: user_id
    tests:
      - not_null
      - relationships:
          to: ref('dim_users')
          field: user_id
```

### 커스텀 테스트 (tests/)

```sql
-- tests/assert_positive_completion_rate.sql
SELECT *
FROM {{ ref('daily_user_stats') }}
WHERE completion_rate < 0 OR completion_rate > 100
```

## 📊 Materialization 전략

- **View**: 쿼리 시점에 실시간 계산 (staging 레이어)
- **Table**: 사전 계산된 결과 저장 (marts 레이어)
- **Incremental**: 새 데이터만 추가 (대용량 테이블)

```sql
-- Incremental 모델 예시
{{ config(
    materialized='incremental',
    unique_key='id'
) }}

SELECT * FROM {{ source('raw', 'todos') }}
{% if is_incremental() %}
WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}
```

## 🔄 Airflow 연동

Airflow DAG에서 dbt 실행:

```python
from airflow.operators.bash import BashOperator

dbt_run = BashOperator(
    task_id='dbt_run',
    bash_command='cd /opt/dbt && dbt run --profiles-dir .',
    dag=dag
)
```

## 💡 Best Practices

1. **계층 구조**: staging → marts 순서로 의존성 관리
2. **명명 규칙**: `stg_*` (staging), `fct_*` (fact), `dim_*` (dimension)
3. **문서화**: 모든 모델에 description 추가
4. **테스트**: 핵심 컬럼에 not_null, unique 테스트 적용
5. **Incremental**: 대용량 테이블은 incremental 전략 사용