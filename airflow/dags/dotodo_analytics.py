from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
import pandas as pd
import json
from typing import Dict, Any


def create_analytics_table_func(**context):
    """분석용 테이블 생성"""
    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')
    
    sql = """
    CREATE TABLE IF NOT EXISTS daily_analytics (
        id SERIAL PRIMARY KEY,
        analysis_date DATE NOT NULL UNIQUE,
        total_users INTEGER,
        avg_completion_rate NUMERIC(5,2),
        most_popular_category VARCHAR(100),
        active_users_last_week INTEGER,
        report_data JSONB,
        created_at TIMESTAMP DEFAULT NOW()
    );
    
    CREATE INDEX IF NOT EXISTS idx_daily_analytics_date 
    ON daily_analytics(analysis_date);
    """
    
    postgres_hook.run(sql)
    print("Analytics table created successfully")


def extract_user_activity_data(**context):
    """사용자 활동 데이터 추출"""
    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')
    
    # 어제 날짜 기준으로 데이터 추출
    yesterday = context['ds']
    
    # 전체 사용자 활동 통계
    query = """
    SELECT 
        user_id,
        COUNT(*) as total_todos,
        COUNT(CASE WHEN completed = true THEN 1 END) as completed_todos,
        COUNT(CASE WHEN completed = false THEN 1 END) as pending_todos,
        COUNT(DISTINCT category) as unique_categories,
        MIN(created_at) as first_activity,
        MAX(updated_at) as last_activity
    FROM todos 
    WHERE DATE(created_at) <= %s
    GROUP BY user_id
    """
    
    df = postgres_hook.get_pandas_df(query, parameters=[yesterday])
    
    # 결과를 XCom에 저장
    return df.to_json(orient='records')


def calculate_completion_rates(**context):
    """완료율 계산 및 분석"""
    # 이전 태스크에서 데이터 가져오기
    ti = context['task_instance']
    user_data_json = ti.xcom_pull(task_ids='extract_user_activity')
    
    if not user_data_json or user_data_json == '[]':
        print("No user data found")
        return {
            'total_users': 0,
            'avg_completion_rate': 0,
            'median_completion_rate': 0,
            'high_performers': 0,
            'low_performers': 0
        }
    
    user_data = pd.read_json(user_data_json)
    
    # 완료율 계산
    user_data['completion_rate'] = (
        user_data['completed_todos'] / user_data['total_todos'] * 100
    ).fillna(0)
    
    # 전체 통계
    analytics = {
        'total_users': len(user_data),
        'avg_completion_rate': user_data['completion_rate'].mean(),
        'median_completion_rate': user_data['completion_rate'].median(),
        'high_performers': len(user_data[user_data['completion_rate'] >= 80]),
        'low_performers': len(user_data[user_data['completion_rate'] < 30])
    }
    
    print(f"Analytics Summary: {analytics}")
    return analytics


def analyze_category_trends(**context):
    """카테고리별 트렌드 분석"""
    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')
    yesterday = context['ds']
    
    # 카테고리별 통계
    query = """
    SELECT 
        category,
        COUNT(*) as total_tasks,
        COUNT(CASE WHEN completed = true THEN 1 END) as completed_tasks,
        ROUND(
            COUNT(CASE WHEN completed = true THEN 1 END)::numeric / 
            COUNT(*)::numeric * 100, 2
        ) as completion_rate,
        COUNT(DISTINCT user_id) as unique_users
    FROM todos 
    WHERE DATE(created_at) <= %s 
        AND category IS NOT NULL
    GROUP BY category
    ORDER BY total_tasks DESC
    """
    
    df = postgres_hook.get_pandas_df(query, parameters=[yesterday])
    
    # 인사이트 생성
    if len(df) > 0:
        insights = {
            'most_popular_category': df.iloc[0]['category'],
            'highest_completion_category': df.loc[df['completion_rate'].idxmax()]['category'],
            'categories_analysis': df.to_dict('records')
        }
    else:
        insights = {
            'most_popular_category': 'unknown',
            'highest_completion_category': 'unknown',
            'categories_analysis': []
        }
    
    return insights


def detect_user_patterns(**context):
    """사용자 패턴 및 이상치 감지"""
    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')
    yesterday = context['ds']
    
    # 일주일간 활동 패턴 분석
    query = """
    WITH daily_activity AS (
        SELECT 
            user_id,
            DATE(created_at) as activity_date,
            COUNT(*) as daily_todos,
            COUNT(CASE WHEN completed = true THEN 1 END) as daily_completed
        FROM todos 
        WHERE created_at >= %s::date - INTERVAL '7 days'
            AND created_at <= %s::date
        GROUP BY user_id, DATE(created_at)
    )
    SELECT 
        user_id,
        COUNT(*) as active_days,
        AVG(daily_todos) as avg_daily_todos,
        AVG(daily_completed) as avg_daily_completed,
        MAX(daily_todos) as max_daily_todos,
        STDDEV(daily_todos) as stddev_daily_todos
    FROM daily_activity
    GROUP BY user_id
    HAVING COUNT(*) >= 3  -- 최소 3일 이상 활동한 사용자만
    """
    
    df = postgres_hook.get_pandas_df(query, parameters=[yesterday, yesterday])
    
    # 이상치 감지 (평균보다 3 표준편차 이상 차이나는 사용자)
    if len(df) > 0:
        mean_todos = df['avg_daily_todos'].mean()
        std_todos = df['avg_daily_todos'].std()
        
        if std_todos > 0:
            outliers = df[
                (df['avg_daily_todos'] > mean_todos + 3 * std_todos) |
                (df['avg_daily_todos'] < mean_todos - 3 * std_todos)
            ]
        else:
            outliers = pd.DataFrame()
        
        patterns = {
            'total_active_users': len(df),
            'avg_activity_days': df['active_days'].mean(),
            'super_users': len(df[df['avg_daily_todos'] > 10]),
            'potential_outliers': len(outliers),
            'outlier_users': outliers['user_id'].tolist() if len(outliers) > 0 else []
        }
    else:
        patterns = {
            'total_active_users': 0,
            'avg_activity_days': 0,
            'super_users': 0,
            'potential_outliers': 0,
            'outlier_users': [],
            'message': 'Insufficient data for pattern analysis'
        }
    
    return patterns


def generate_daily_summary(**context):
    """일일 요약 리포트 생성"""
    ti = context['task_instance']
    
    # 이전 태스크들의 결과 수집
    completion_stats = ti.xcom_pull(task_ids='calculate_completion_rates')
    category_insights = ti.xcom_pull(task_ids='analyze_category_trends')
    user_patterns = ti.xcom_pull(task_ids='detect_user_patterns')
    
    # 종합 리포트 생성
    daily_report = {
        'date': context['ds'],
        'summary': {
            'total_users': completion_stats.get('total_users', 0),
            'avg_completion_rate': round(completion_stats.get('avg_completion_rate', 0), 2),
            'most_popular_category': category_insights.get('most_popular_category'),
            'active_users_last_week': user_patterns.get('total_active_users', 0)
        },
        'completion_analysis': completion_stats,
        'category_trends': category_insights,
        'user_behavior': user_patterns,
        'recommendations': generate_recommendations(completion_stats, category_insights, user_patterns)
    }
    
    # 결과를 로그에 출력
    print("=" * 60)
    print(f"DoTodo Daily Analytics Report - {context['ds']}")
    print("=" * 60)
    print(json.dumps(daily_report['summary'], indent=2))
    print("\nRecommendations:")
    for rec in daily_report['recommendations']:
        print(f"- {rec}")
    print("=" * 60)
    
    return daily_report


def generate_recommendations(completion_stats, category_insights, user_patterns):
    """비즈니스 추천사항 생성"""
    recommendations = []
    
    # 완료율 기반 추천
    avg_completion = completion_stats.get('avg_completion_rate', 0)
    if avg_completion < 50:
        recommendations.append("전체 완료율이 낮습니다. 사용자 경험 개선이 필요합니다.")
    elif avg_completion > 80:
        recommendations.append("높은 완료율을 보이고 있습니다. 현재 전략을 유지하세요.")
    
    # 카테고리 기반 추천
    if category_insights.get('most_popular_category') and category_insights.get('most_popular_category') != 'unknown':
        recommendations.append(
            f"'{category_insights['most_popular_category']}' 카테고리가 가장 인기입니다. "
            "관련 기능 강화를 고려하세요."
        )
    
    # 사용자 활동 기반 추천
    super_users = user_patterns.get('super_users', 0)
    total_users = user_patterns.get('total_active_users', 1)
    if total_users > 0 and super_users / total_users > 0.1:  # 10% 이상이 파워유저
        recommendations.append("파워유저 비율이 높습니다. 고급 기능 개발을 고려하세요.")
    
    if not recommendations:
        recommendations.append("모든 지표가 정상 범위입니다.")
    
    return recommendations


def save_analytics_results(**context):
    """분석 결과를 데이터베이스에 저장"""
    ti = context['task_instance']
    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')
    
    completion_stats = ti.xcom_pull(task_ids='calculate_completion_rates')
    category_insights = ti.xcom_pull(task_ids='analyze_category_trends')
    user_patterns = ti.xcom_pull(task_ids='detect_user_patterns')
    daily_report = ti.xcom_pull(task_ids='generate_daily_summary')
    
    sql = """
    INSERT INTO daily_analytics (
        analysis_date, total_users, avg_completion_rate, 
        most_popular_category, active_users_last_week, report_data
    ) VALUES (%s, %s, %s, %s, %s, %s)
    ON CONFLICT (analysis_date) DO UPDATE SET
        total_users = EXCLUDED.total_users,
        avg_completion_rate = EXCLUDED.avg_completion_rate,
        most_popular_category = EXCLUDED.most_popular_category,
        active_users_last_week = EXCLUDED.active_users_last_week,
        report_data = EXCLUDED.report_data,
        created_at = NOW();
    """
    
    postgres_hook.run(sql, parameters=[
        context['ds'],
        completion_stats.get('total_users', 0),
        completion_stats.get('avg_completion_rate', 0),
        category_insights.get('most_popular_category', 'unknown'),
        user_patterns.get('total_active_users', 0),
        json.dumps(daily_report)
    ])
    
    print(f"Analytics results saved for {context['ds']}")


# DAG 정의
default_args = {
    'owner': 'dotodo-team',
    'depends_on_past': False,
    'start_date': datetime(2025, 9, 26),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'dotodo_daily_analytics',
    default_args=default_args,
    description='DoTodo 일일 데이터 분석 파이프라인',
    schedule='0 1 * * *',  # 매일 새벽 1시 실행
    catchup=False,
    max_active_runs=1,
    tags=['analytics', 'daily', 'dotodo']
)

# 집계 테이블 생성
create_analytics_table = PythonOperator(
    task_id='create_analytics_table',
    python_callable=create_analytics_table_func,
    dag=dag
)

# 데이터 추출
extract_data = PythonOperator(
    task_id='extract_user_activity',
    python_callable=extract_user_activity_data,
    dag=dag
)

# 완료율 분석
analyze_completion = PythonOperator(
    task_id='calculate_completion_rates',
    python_callable=calculate_completion_rates,
    dag=dag
)

# 카테고리 트렌드 분석
analyze_categories = PythonOperator(
    task_id='analyze_category_trends',
    python_callable=analyze_category_trends,
    dag=dag
)

# 사용자 패턴 분석
analyze_patterns = PythonOperator(
    task_id='detect_user_patterns',
    python_callable=detect_user_patterns,
    dag=dag
)

# 일일 요약 생성
generate_summary = PythonOperator(
    task_id='generate_daily_summary',
    python_callable=generate_daily_summary,
    dag=dag
)

# 결과를 데이터베이스에 저장
save_analytics = PythonOperator(
    task_id='save_analytics_results',
    python_callable=save_analytics_results,
    dag=dag
)

# 태스크 의존성 설정
create_analytics_table >> extract_data
extract_data >> [analyze_completion, analyze_categories, analyze_patterns]
[analyze_completion, analyze_categories, analyze_patterns] >> generate_summary
generate_summary >> save_analytics
