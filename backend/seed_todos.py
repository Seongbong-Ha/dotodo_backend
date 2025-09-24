#!/usr/bin/env python3
import json
import os
import psycopg2
from psycopg2.extras import RealDictCursor

def insert_todos():
    # JSON 데이터 로드
    with open('todos.json', 'r', encoding='utf-8') as f:
        todos_data = json.load(f)
    
    # 환경변수에서 DB 정보 가져오기
    conn = psycopg2.connect(
        host="db",
        port="5432", 
        database=os.getenv('POSTGRES_DB', 'dotodo'),
        user=os.getenv('POSTGRES_USER', 'postgres'),
        password=os.getenv('POSTGRES_PASSWORD', 'postgres')
    )
    cursor = conn.cursor()
    
    try:
        insert_query = """
        INSERT INTO todos (
            user_id, task, category, completed, 
            scheduled_date, completed_at, source, 
            created_at, updated_at
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        
        for todo in todos_data:
            completed_at = todo.get('completed_at')
            if completed_at == "null" or completed_at is None:
                completed_at = None
            
            cursor.execute(insert_query, (
                todo['user_id'], todo['task'], todo['category'],
                todo['completed'], todo['scheduled_date'], completed_at,
                todo['source'], todo['created_at'], todo['updated_at']
            ))
        
        conn.commit()
        print(f"성공: {len(todos_data)}개 할일 데이터 삽입 완료")
        
        # 확인
        cursor.execute("SELECT COUNT(*) FROM todos")
        count = cursor.fetchone()[0]
        print(f"총 할일 개수: {count}")
        
        # 카테고리별 분포 확인
        cursor.execute("SELECT category, COUNT(*) FROM todos GROUP BY category ORDER BY COUNT(*) DESC")
        categories = cursor.fetchall()
        print("\n카테고리별 분포:")
        for cat, count in categories:
            print(f"  - {cat}: {count}개")
        
    except Exception as e:
        conn.rollback()
        print(f"오류: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    insert_todos()