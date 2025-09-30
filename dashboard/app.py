import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from sqlalchemy import create_engine
from datetime import datetime, timedelta

# 페이지 설정
st.set_page_config(
    page_title="DoTodo 분석 대시보드",
    page_icon="📊",
    layout="wide"
)

# DB 연결
@st.cache_resource
def get_connection():
    DATABASE_URL = "postgresql://postgres:postgres@db:5432/dotodo"
    return create_engine(DATABASE_URL)

engine = get_connection()

# 데이터 로드
@st.cache_data(ttl=300)
def load_daily_stats():
    query = "SELECT * FROM analytics_marts.daily_user_stats ORDER BY created_date DESC"
    return pd.read_sql(query, engine)

@st.cache_data(ttl=300)
def load_category_summary():
    query = "SELECT * FROM analytics_marts.category_summary ORDER BY total_tasks DESC"
    return pd.read_sql(query, engine)


@st.cache_data(ttl=300)
def load_airflow_analytics():
    query = """
    SELECT 
        analysis_date,
        total_users,
        avg_completion_rate,
        most_popular_category,
        active_users_last_week,
        report_data,
        created_at
    FROM daily_analytics
    ORDER BY analysis_date DESC
    LIMIT 30
    """
    return pd.read_sql(query, engine)

# 타이틀
st.title("DoTodo 사용자 행동 분석 대시보드")
st.markdown("---")

# 데이터 로드
try:
    daily_stats = load_daily_stats()
    category_summary = load_category_summary()
    
    # 핵심 지표 (상단)
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        total_users = daily_stats['user_id'].nunique()
        st.metric("전체 사용자", f"{total_users}명")
    
    with col2:
        avg_completion = daily_stats['completion_rate'].mean()
        st.metric("평균 완료율", f"{avg_completion:.1f}%")
    
    with col3:
        total_tasks = daily_stats['total_tasks'].sum()
        st.metric("총 할일 수", f"{total_tasks:,}개")
    
    with col4:
        completed_tasks = daily_stats['completed_tasks'].sum()
        st.metric("완료된 할일", f"{completed_tasks:,}개")
    
    st.markdown("---")
    
    # 2개 컬럼으로 차트 배치
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("일별 완료율 추이")
        daily_agg = daily_stats.groupby('created_date').agg({
            'completion_rate': 'mean',
            'total_tasks': 'sum'
        }).reset_index()
        
        fig1 = px.line(
            daily_agg, 
            x='created_date', 
            y='completion_rate',
            labels={'created_date': '날짜', 'completion_rate': '완료율 (%)'},
            markers=True
        )
        fig1.update_layout(height=350, showlegend=False)
        st.plotly_chart(fig1, use_container_width=True)
    
    with col2:
        st.subheader("카테고리별 할일 분포")
        fig2 = px.bar(
            category_summary,
            x='category',
            y='total_tasks',
            labels={'category': '카테고리', 'total_tasks': '할일 수'},
            color='completion_rate',
            color_continuous_scale='RdYlGn'
        )
        fig2.update_layout(height=350)
        st.plotly_chart(fig2, use_container_width=True)
    
    # 하단 차트
    col3, col4 = st.columns(2)
    
    with col3:
        st.subheader("카테고리별 완료율")
        fig3 = px.bar(
            category_summary,
            x='category',
            y='completion_rate',
            labels={'category': '카테고리', 'completion_rate': '완료율 (%)'},
            color='completion_rate',
            color_continuous_scale='Viridis'
        )
        fig3.update_layout(height=350)
        st.plotly_chart(fig3, use_container_width=True)
    
    with col4:
        st.subheader("일일 활동량")
        fig4 = px.area(
            daily_agg,
            x='created_date',
            y='total_tasks',
            labels={'created_date': '날짜', 'total_tasks': '할일 수'}
        )
        fig4.update_layout(height=350, showlegend=False)
        st.plotly_chart(fig4, use_container_width=True)
    
    # 상세 데이터 테이블 (접을 수 있게)
    with st.expander("📋 상세 데이터 보기"):
        tab1, tab2 = st.tabs(["일별 통계", "카테고리 요약"])
        
        with tab1:
            st.dataframe(daily_stats, use_container_width=True)
        
        with tab2:
            st.dataframe(category_summary, use_container_width=True)

except Exception as e:
    st.error(f"데이터 로드 오류: {e}")
    st.info("dbt 모델이 실행되었는지 확인하세요: `docker-compose exec dbt dbt run`")


st.markdown("---")
st.header("Airflow 일일 분석 리포트")

try:
    airflow_data = load_airflow_analytics()
    
    if not airflow_data.empty:
        # 최신 분석 날짜
        latest_date = airflow_data['analysis_date'].iloc[0]
        st.subheader(f"최신 분석: {latest_date}")
        
        # 지표 카드
        col1, col2, col3 = st.columns(3)
        latest = airflow_data.iloc[0]
        
        with col1:
            st.metric("분석 기준 사용자 수", f"{latest['total_users']}명")
        
        with col2:
            st.metric("평균 완료율", f"{latest['avg_completion_rate']:.1f}%")
        
        with col3:
            st.metric("인기 카테고리", latest['most_popular_category'])
        
        # 시계열 차트
        st.subheader("일일 분석 추이")
        
        col1, col2 = st.columns(2)
        
        with col1:
            fig_users = px.line(
                airflow_data,
                x='analysis_date',
                y='total_users',
                labels={'analysis_date': '날짜', 'total_users': '활성 사용자 수'},
                markers=True
            )
            st.plotly_chart(fig_users, use_container_width=True)
        
        with col2:
            fig_completion = px.line(
                airflow_data,
                x='analysis_date',
                y='avg_completion_rate',
                labels={'analysis_date': '날짜', 'avg_completion_rate': '평균 완료율 (%)'},
                markers=True
            )
            st.plotly_chart(fig_completion, use_container_width=True)
        
        # 상세 리포트 (접을 수 있게)
        with st.expander("상세 분석 데이터"):
            st.dataframe(airflow_data, use_container_width=True)
    else:
        st.info("Airflow 분석 데이터가 아직 생성되지 않았습니다. DAG를 실행하거나 새벽 1시까지 기다려주세요.")
        
except Exception as e:
    st.warning(f"Airflow 분석 데이터를 불러올 수 없습니다: {e}")