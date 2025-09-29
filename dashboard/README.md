# Dashboard - Streamlit Visualization

> DoTodo 데이터 분석 대시보드

## 📋 개요

Streamlit 기반의 실시간 데이터 모니터링 대시보드로 사용자 행동 분석 및 주요 지표를 시각화합니다.

## 🏗️ 프로젝트 구조

```
dashboard/
├── app.py                    # 메인 대시보드 앱
├── requirements.txt          # Python 패키지 의존성
├── Dockerfile               # Docker 이미지 설정
└── .streamlit/
    └── config.toml          # Streamlit 테마 설정
```

## 📊 대시보드 구성

### 핵심 지표 (상단)
- **전체 사용자 수**: 등록된 사용자 총 인원
- **평균 완료율**: 전체 사용자의 평균 할일 완료율
- **총 할일 수**: 생성된 전체 할일 개수
- **완료된 할일**: 완료 처리된 할일 개수

### 차트

#### 1. 일별 완료율 추이 (Line Chart)
시간에 따른 사용자들의 평균 완료율 변화를 추적합니다.

**데이터 소스**: `analytics.daily_user_stats`
```sql
SELECT created_date, AVG(completion_rate) as avg_rate
FROM analytics_marts.daily_user_stats
GROUP BY created_date
```

#### 2. 카테고리별 할일 분포 (Bar Chart)
각 카테고리별 할일 개수와 완료율을 색상으로 표현합니다.

**데이터 소스**: `analytics.category_summary`
```sql
SELECT category, total_tasks, completion_rate
FROM analytics_marts.category_summary
ORDER BY total_tasks DESC
```

#### 3. 카테고리별 완료율 (Bar Chart)
각 카테고리의 완료율을 비교합니다.

#### 4. 일일 활동량 (Area Chart)
날짜별 생성된 할일 수의 변화를 영역 차트로 표시합니다.

### 상세 데이터 테이블
접을 수 있는 섹션에서 원본 데이터를 확인할 수 있습니다:
- **일별 통계**: 사용자별 일일 활동 상세 데이터
- **카테고리 요약**: 카테고리별 집계 통계

## 🚀 사용 방법

### Docker로 실행 (권장)
```bash
# 루트 디렉토리에서
docker-compose up dashboard
```

대시보드 접속: http://localhost:8501

### 로컬에서 직접 실행
```bash
cd dashboard

# 가상환경 생성
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 의존성 설치
pip install -r requirements.txt

# Streamlit 실행
streamlit run app.py
```

## ⚙️ 환경 변수

`.env` 파일 또는 `docker-compose.yaml`에서 설정:

```env
DATABASE_URL=postgresql://postgres:postgres@db:5432/dotodo
```

## 🔧 커스터마이징

### 새로운 차트 추가

```python
# app.py에 추가
@st.cache_data(ttl=300)
def load_new_metric():
    query = "SELECT * FROM analytics_marts.new_metric"
    return pd.read_sql(query, engine)

# 차트 생성
st.subheader("새로운 지표")
new_data = load_new_metric()

fig = px.bar(new_data, x='category', y='value')
st.plotly_chart(fig, use_container_width=True)
```

### 테마 변경

`.streamlit/config.toml` 수정:

```toml
[theme]
primaryColor = "#FF4B4B"        # 주요 색상
backgroundColor = "#FFFFFF"      # 배경색
secondaryBackgroundColor = "#F0F2F6"  # 보조 배경색
textColor = "#262730"           # 텍스트 색상
font = "sans serif"             # 폰트
```

### 캐시 설정

데이터 갱신 주기 조정:

```python
# 5분마다 캐시 갱신
@st.cache_data(ttl=300)
def load_data():
    return pd.read_sql(query, engine)

# 10분마다 캐시 갱신
@st.cache_data(ttl=600)
def load_heavy_data():
    return pd.read_sql(heavy_query, engine)
```

## 📦 주요 패키지

- **streamlit**: 대시보드 프레임워크
- **pandas**: 데이터 처리
- **plotly**: 인터랙티브 차트
- **sqlalchemy**: 데이터베이스 연결
- **psycopg2**: PostgreSQL 드라이버

## 🔗 데이터 소스

대시보드는 dbt로 생성된 분석 테이블을 사용합니다:

```
analytics_marts.daily_user_stats    # 일별 사용자 통계
analytics_marts.category_summary    # 카테고리 요약
```

**데이터 파이프라인:**
```
PostgreSQL (raw) 
  → dbt (transformation) 
    → analytics schema 
      → Streamlit (visualization)
```

## 🧪 테스트

### 로컬 테스트
```bash
# 대시보드 실행
streamlit run app.py

# 브라우저에서 http://localhost:8501 확인
```

### DB 연결 테스트
```python
# Python 콘솔에서
from sqlalchemy import create_engine
engine = create_engine("postgresql://postgres:postgres@db:5432/dotodo")
engine.connect()
```

## 🎨 차트 라이브러리

### Plotly Express 사용 예시

```python
import plotly.express as px

# Line Chart
fig = px.line(df, x='date', y='value', markers=True)

# Bar Chart
fig = px.bar(df, x='category', y='count', color='metric')

# Area Chart
fig = px.area(df, x='date', y='value')

# Pie Chart
fig = px.pie(df, values='count', names='category')

st.plotly_chart(fig, use_container_width=True)
```

## 📊 사용자 인터랙션

### 필터 추가

```python
# 사이드바에 날짜 필터
st.sidebar.header("필터")
date_range = st.sidebar.date_input(
    "날짜 범위",
    value=(datetime.now() - timedelta(days=7), datetime.now())
)

# 필터 적용
filtered_data = data[
    (data['created_date'] >= date_range[0]) &
    (data['created_date'] <= date_range[1])
]
```

### 다운로드 버튼

```python
# CSV 다운로드
csv = df.to_csv(index=False).encode('utf-8')
st.download_button(
    label="CSV 다운로드",
    data=csv,
    file_name='data.csv',
    mime='text/csv'
)
```

## 🔄 데이터 새로고침

### 자동 새로고침
```python
# 30초마다 자동 새로고침
import time
st_autorefresh = st.empty()
while True:
    with st_autorefresh:
        st.rerun()
    time.sleep(30)
```

### 수동 새로고침 버튼
```python
if st.button("데이터 새로고침"):
    st.cache_data.clear()
    st.rerun()
```

## 💡 Best Practices

1. **캐싱 활용**: 무거운 쿼리는 반드시 `@st.cache_data` 사용
2. **레이아웃**: `st.columns()`로 차트를 좌우 배치하여 공간 효율적 사용
3. **로딩 표시**: 데이터 로드 중 `st.spinner()` 표시
4. **에러 핸들링**: `try-except`로 DB 연결 오류 처리
5. **반응형**: `use_container_width=True`로 화면 크기에 맞춤

## 🐛 문제 해결

### 대시보드가 로드되지 않을 때
```bash
# dbt 모델이 실행되었는지 확인
docker-compose exec dbt dbt run

# DB 테이블 확인
docker-compose exec db psql -U postgres -d dotodo -c "\dt analytics_marts.*"
```

### 데이터가 표시되지 않을 때
```bash
# 캐시 클리어
# Streamlit UI에서 'C' 키 → Clear cache

# 또는 앱 재시작
docker-compose restart dashboard
```

### 포트 충돌
```yaml
# docker-compose.yaml 수정
dashboard:
  ports:
    - "8502:8501"  # 다른 포트로 변경
```