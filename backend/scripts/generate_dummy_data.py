"""
DoTodo 더미 데이터 생성 스크립트

실행 방법:
docker-compose exec backend python scripts/generate_dummy_data.py
"""

import sys
import os
sys.path.append('/app')

import random
from datetime import datetime, timedelta
from sqlalchemy.orm import Session

from app.core.database import SessionLocal
from app.models import Todo, Recommendation

# 카테고리별 할일 템플릿
TASKS_BY_CATEGORY = {
    "업무": [
        "회의 참석하기", "이메일 답장하기", "보고서 작성하기", 
        "프로젝트 기획안 검토", "팀 미팅 준비", "업무 인수인계",
        "문서 정리하기", "클라이언트 미팅", "제안서 작성"
    ],
    "운동": [
        "조깅하기", "스트레칭하기", "헬스장 가기", 
        "요가하기", "산책하기", "홈트레이닝",
        "수영하기", "자전거 타기", "등산하기"
    ],
    "공부": [
        "영어 공부하기", "책 읽기", "온라인 강의 듣기",
        "자격증 공부", "코딩 연습", "논문 읽기",
        "단어 암기하기", "문제 풀기", "강의 복습"
    ],
    "집안일": [
        "청소하기", "빨래하기", "설거지하기",
        "장보기", "요리하기", "정리정돈",
        "화분 물주기", "쓰레기 버리기", "침구 빨기"
    ],
    "기타": [
        "병원 가기", "약국 들르기", "은행 업무 보기",
        "우체국 방문", "친구 만나기", "전화하기",
        "택배 보내기", "정비소 방문", "헤어샵 예약"
    ]
}

def clear_existing_data(db: Session):
    """기존 더미 데이터 삭제"""
    print("🗑️  기존 데이터 삭제 중...")
    
    # user_001 ~ user_010 데이터만 삭제
    for i in range(1, 11):
        user_id = f"user_{str(i).zfill(3)}"
        db.query(Todo).filter(Todo.user_id == user_id).delete()
        db.query(Recommendation).filter(Recommendation.user_id == user_id).delete()
    
    db.commit()
    print("✅ 기존 데이터 삭제 완료")

def generate_todos_for_user(db: Session, user_id: str, days: int = 30):
    """특정 사용자의 할일 데이터 생성"""
    
    print(f"📝 {user_id} 데이터 생성 중...")
    
    end_date = datetime.now().date()
    start_date = end_date - timedelta(days=days-1)
    
    total_todos = 0
    
    for day_offset in range(days):
        current_date = start_date + timedelta(days=day_offset)
        
        # 날짜별로 할일 개수 랜덤 (2~8개)
        num_todos = random.randint(2, 8)
        
        # 날짜별 완료율을 랜덤하게 설정 (40%~90%)
        completion_rate = random.uniform(0.4, 0.9)
        
        # 카테고리별로 할일 분배
        categories = list(TASKS_BY_CATEGORY.keys())
        
        for _ in range(num_todos):
            # 랜덤 카테고리 선택
            category = random.choice(categories)
            
            # 해당 카테고리에서 랜덤 할일 선택
            task = random.choice(TASKS_BY_CATEGORY[category])
            
            # 완료 여부 결정
            is_completed = random.random() < completion_rate
            
            # completed_at 설정 (완료된 경우)
            completed_at = None
            if is_completed:
                # 당일 중 랜덤 시간에 완료
                completed_at = datetime.combine(
                    current_date, 
                    datetime.min.time()
                ) + timedelta(
                    hours=random.randint(8, 22),
                    minutes=random.randint(0, 59)
                )
            
            # Todo 생성
            todo = Todo(
                user_id=user_id,
                task=task,
                category=category,
                completed=is_completed,
                scheduled_date=current_date,
                completed_at=completed_at,
                source="voice_parsing",
                created_at=datetime.combine(current_date, datetime.min.time()),
                updated_at=datetime.combine(current_date, datetime.min.time())
            )
            
            db.add(todo)
            total_todos += 1
    
    db.commit()
    print(f"✅ {user_id}: {total_todos}개 할일 생성 완료")

def generate_recommendations(db: Session, user_id: str):
    """특정 사용자의 추천 데이터 생성"""
    
    print(f"💡 {user_id} 추천 데이터 생성 중...")
    
    # 최근 7일간 랜덤으로 추천 생성
    num_recommendations = random.randint(3, 7)
    
    for _ in range(num_recommendations):
        days_ago = random.randint(0, 7)
        rec_date = datetime.now() - timedelta(days=days_ago)
        
        category = random.choice(list(TASKS_BY_CATEGORY.keys()))
        task = random.choice(TASKS_BY_CATEGORY[category])
        
        recommendation = Recommendation(
            user_id=user_id,
            recommended_task=task,
            category=category,
            reason="사용자 패턴 기반 맞춤 추천",
            accepted=random.choice([True, False, None]),
            created_at=rec_date
        )
        
        db.add(recommendation)
    
    db.commit()
    print(f"✅ {user_id}: {num_recommendations}개 추천 생성 완료")

def main():
    """메인 실행 함수"""
    
    print("=" * 60)
    print("🎲 DoTodo 더미 데이터 생성 시작")
    print("=" * 60)
    
    db = SessionLocal()
    
    try:
        # 1. 기존 데이터 삭제
        clear_existing_data(db)
        
        print("\n" + "=" * 60)
        print("📊 새로운 더미 데이터 생성")
        print("=" * 60 + "\n")
        
        # 2. user_001 ~ user_010 데이터 생성
        for i in range(1, 11):
            user_id = f"user_{str(i).zfill(3)}"
            
            # 할일 데이터 생성 (최근 30일)
            generate_todos_for_user(db, user_id, days=30)
            
            # 추천 데이터 생성
            generate_recommendations(db, user_id)
            
            print()  # 사용자별 구분선
        
        print("=" * 60)
        print("✨ 모든 더미 데이터 생성 완료!")
        print("=" * 60)
        
        # 생성된 데이터 통계
        total_todos = db.query(Todo).count()
        total_recommendations = db.query(Recommendation).count()
        
        print(f"\n📊 생성된 데이터 통계:")
        print(f"  - 전체 할일: {total_todos}개")
        print(f"  - 전체 추천: {total_recommendations}개")
        print(f"  - 사용자 수: 10명 (user_001 ~ user_010)")
        
    except Exception as e:
        print(f"\n❌ 오류 발생: {e}")
        db.rollback()
        raise
    finally:
        db.close()

if __name__ == "__main__":
    main()