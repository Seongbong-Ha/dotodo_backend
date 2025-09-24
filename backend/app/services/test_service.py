import json
import os
from datetime import datetime, timedelta
from typing import List, Dict, Any
from sqlalchemy.orm import Session
from sqlalchemy import and_

from ..core.database import SessionLocal
from ..models import Todo


def get_p_data_from_db(user_id: str, start_date: str, end_date: str) -> List[Dict]:
    """
    지난 7일간 완료된 할일 데이터를 DB에서 조회
    
    Args:
        user_id: 사용자 ID
        start_date: 시작 날짜 (YYYY-MM-DD)
        end_date: 종료 날짜 (YYYY-MM-DD)
    
    Returns:
        List[Dict]: p_data 형태의 데이터
    """
    print(f"📊 P_DATA 조회 시작: {start_date} ~ {end_date}")
    
    db: Session = SessionLocal()
    try:
        # 완료된 할일만 조회 (completed=True)
        todos = db.query(Todo).filter(
            and_(
                Todo.user_id == user_id,
                Todo.scheduled_date >= start_date,
                Todo.scheduled_date <= end_date,
                Todo.completed == True
            )
        ).order_by(Todo.scheduled_date).all()
        
        print(f"✅ 완료된 할일 {len(todos)}개 조회됨")
        
        # 날짜별로 그룹핑
        date_grouped = {}
        for todo in todos:
            date_str = todo.scheduled_date.strftime("%Y-%m-%d")
            if date_str not in date_grouped:
                date_grouped[date_str] = {}
            
            category = todo.category
            if category not in date_grouped[date_str]:
                date_grouped[date_str][category] = []
            
            date_grouped[date_str][category].append({
                "todo": todo.task,
                "completed": True
            })
        
        # p_data 형태로 변환
        p_data = []
        for date_str, categories in date_grouped.items():
            p_data.append({
                "user_id": user_id,
                "date": date_str,
                "completed_todos": categories
            })
        
        # 날짜순 정렬
        p_data.sort(key=lambda x: x["date"])
        
        return p_data
        
    except Exception as e:
        print(f"❌ P_DATA 조회 오류: {e}")
        return []
    finally:
        db.close()


def get_h_data_from_db(user_id: str, target_date: str) -> Dict:
    """
    특정 날짜의 모든 할일 데이터를 DB에서 조회 (H_DATA)
    
    Args:
        user_id: 사용자 ID  
        target_date: 대상 날짜 (YYYY-MM-DD)
    
    Returns:
        Dict: h_data 형태의 데이터
    """
    print(f"📅 H_DATA 조회 시작: {target_date}")
    
    db: Session = SessionLocal()
    try:
        # 해당 날짜의 모든 할일 조회 (완료/미완료 상관없이)
        todos = db.query(Todo).filter(
            and_(
                Todo.user_id == user_id,
                Todo.scheduled_date == target_date
            )
        ).order_by(Todo.category, Todo.id).all()
        
        print(f"✅ 해당 날짜 할일 {len(todos)}개 조회됨")
        
        # 카테고리별로 그룹핑
        category_grouped = {}
        for todo in todos:
            category = todo.category
            if category not in category_grouped:
                category_grouped[category] = []
            
            category_grouped[category].append({
                "todo": todo.task,
                "completed": todo.completed
            })
        
        # h_data 형태로 변환
        h_data = {
            "user_id": user_id,
            "date": target_date,
            "scheduled_todos": category_grouped
        }
        
        return h_data
        
    except Exception as e:
        print(f"❌ H_DATA 조회 오류: {e}")
        return {}
    finally:
        db.close()


def convert_to_dummy_format(p_data: List[Dict], h_data: Dict) -> Dict:
    """
    DB에서 조회한 데이터를 dummy_data.json 형태로 변환
    
    Args:
        p_data: 지난 7일 완료된 할일 데이터
        h_data: 오늘 예정된 할일 데이터
    
    Returns:
        Dict: dummy_data.json 형태의 데이터
    """
    print("🔄 데이터 형태 변환 시작")
    
    try:
        dummy_data = {
            "p_data": p_data,
            "h_data": h_data
        }
        
        print("✅ 데이터 형태 변환 완료")
        return dummy_data
        
    except Exception as e:
        print(f"❌ 데이터 변환 오류: {e}")
        return {}


def save_json_file(data: Dict, filename: str, save_path: str = None) -> bool:
    """
    데이터를 JSON 파일로 저장
    
    Args:
        data: 저장할 데이터
        filename: 파일명
        save_path: 저장 경로 (None이면 현재 디렉토리)
    
    Returns:
        bool: 저장 성공 여부
    """
    try:
        if save_path is None:
            # 현재 파일의 상위 디렉토리(app)를 기준으로 저장
            current_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
            file_path = os.path.join(current_dir, filename)
        else:
            file_path = os.path.join(save_path, filename)
        
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        print(f"💾 파일 저장 완료: {file_path}")
        return True
        
    except Exception as e:
        print(f"❌ 파일 저장 오류: {e}")
        return False


def generate_dummy_data_from_db(user_id: str = "user_001", base_date: str = "2025-09-22") -> Dict:
    """
    DB에서 데이터를 조회하여 dummy_data.json 형태로 생성
    
    Args:
        user_id: 사용자 ID (기본값: "user_001")
        base_date: 기준 날짜 (기본값: "2025-09-22")
    
    Returns:
        Dict: 생성된 dummy_data
    """
    print("=" * 60)
    print("🚀 DUMMY DATA 생성 시작")
    print("=" * 60)
    
    try:
        # 날짜 계산
        base_dt = datetime.strptime(base_date, "%Y-%m-%d")
        start_dt = base_dt - timedelta(days=7)
        end_dt = base_dt - timedelta(days=1)
        
        start_date = start_dt.strftime("%Y-%m-%d")
        end_date = end_dt.strftime("%Y-%m-%d")
        
        print(f"👤 사용자: {user_id}")
        print(f"📅 P_DATA 기간: {start_date} ~ {end_date} (지난 7일)")
        print(f"📅 H_DATA 날짜: {base_date} (오늘)")
        print("-" * 60)
        
        # 1. P_DATA 조회 (지난 7일 완료된 할일)
        p_data = get_p_data_from_db(user_id, start_date, end_date)
        print(f"📊 P_DATA: {len(p_data)}일의 데이터 조회")
        
        # 2. H_DATA 조회 (오늘 모든 할일)
        h_data = get_h_data_from_db(user_id, base_date)
        total_h_todos = sum(len(todos) for todos in h_data.get("scheduled_todos", {}).values())
        print(f"📅 H_DATA: {total_h_todos}개 할일 조회")
        
        # 3. 데이터 형태 변환
        dummy_data = convert_to_dummy_format(p_data, h_data)
        
        # 4. 파일 저장
        filename = f"dummy_data_generated_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        save_success = save_json_file(dummy_data, filename)
        
        print("-" * 60)
        if save_success:
            print("🎉 DUMMY DATA 생성 완료!")
        else:
            print("⚠️ 파일 저장 실패했지만 데이터는 생성됨")
        print("=" * 60)
        
        return dummy_data
        
    except Exception as e:
        print(f"💥 DUMMY DATA 생성 실패: {e}")
        return {}


def print_data_summary(data: Dict) -> None:
    """
    생성된 데이터의 요약 정보 출력
    
    Args:
        data: 생성된 dummy_data
    """
    if not data:
        print("📋 요약할 데이터가 없습니다.")
        return
    
    print("\n" + "=" * 50)
    print("📋 데이터 요약")
    print("=" * 50)
    
    # P_DATA 요약
    p_data = data.get("p_data", [])
    print(f"🔸 P_DATA: {len(p_data)}일")
    for day in p_data:
        date = day.get("date", "")
        categories = day.get("completed_todos", {})
        total_todos = sum(len(todos) for todos in categories.values())
        print(f"   {date}: {total_todos}개 완료 ({', '.join(categories.keys())})")
    
    # H_DATA 요약
    h_data = data.get("h_data", {})
    h_date = h_data.get("date", "")
    h_categories = h_data.get("scheduled_todos", {})
    h_total = sum(len(todos) for todos in h_categories.values())
    h_completed = sum(len([t for t in todos if t.get("completed", False)]) for todos in h_categories.values())
    
    print(f"🔸 H_DATA: {h_date}")
    print(f"   총 {h_total}개 할일 (완료: {h_completed}개, 미완료: {h_total - h_completed}개)")
    for category, todos in h_categories.items():
        completed_count = len([t for t in todos if t.get("completed", False)])
        print(f"   {category}: {len(todos)}개 (완료: {completed_count}개)")
    
    print("=" * 50)


if __name__ == "__main__":
    """
    테스트 스크립트로 직접 실행할 때 사용
    """
    print("🧪 테스트 모드로 실행")
    
    # 데이터 생성
    result = generate_dummy_data_from_db()
    
    # 결과 요약 출력
    print_data_summary(result)
    
    # 샘플 데이터 출력 (처음 몇 개만)
    if result:
        print("\n📄 샘플 데이터:")
        print(json.dumps(result, ensure_ascii=False, indent=2)[:500] + "...")