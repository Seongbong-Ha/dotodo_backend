import sys
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime
from sqlalchemy import and_
import re

from ..core.database import get_db
from ..schemas import TodoParseRequest, TodoParseResponse, ParsedTodoItem
from ..services import get_model_service
from ..models import Todo

router = APIRouter(prefix="/api", tags=["todos"])

@router.post("/todos", response_model=TodoParseResponse)
async def parse_voice_to_todos(
    request: TodoParseRequest,
    db: Session = Depends(get_db)
):
    """음성 텍스트를 할 일 목록으로 분석"""
    try:
        # 모델 서비스 호출
        model_service = get_model_service()
        todos_data = await model_service.parse_voice_text(
            user_id=request.user_id,
            text=request.text
        )
        
        # ParsedTodoItem 스키마로 변환
        todo_items = [ParsedTodoItem(**todo) for todo in todos_data]
        
        # 응답 생성 (원래 명세에 맞게)
        response = TodoParseResponse(
            success=True,
            todos=todo_items
        )
        
        # DB에 파싱된 할일들 저장 (선택사항)
        for todo_item in todo_items:
            db_todo = Todo(
                user_id=request.user_id,
                task=todo_item.todo,
                category=todo_item.category,
                completed=False,
                source="voice_parsing"
            )
            db.add(db_todo)
        
        try:
            db.commit()
        except Exception as db_error:
            print(f"DB 저장 오류 (무시하고 계속): {db_error}")
            db.rollback()
        
        return response
        
    except Exception as e:
        # 실패 시 success: false 반환
        return TodoParseResponse(
            success=False,
            todos=[]
        )
        

# todos.py에 추가할 완료 처리 API
@router.post("/todos/complete")
async def complete_todo(
    user_id: str,
    id: int,
    task: str,
    db: Session = Depends(get_db)
):
    """
    할일 완료 처리
    
    Args:
        user_id: 사용자 ID
        id: 완료할 할일 ID  
        task: 최신 할일 내용 (로컬 DB에서 수정된 내용)
    
    Returns:
        완료 처리된 할일 정보
    """
    
    try:
        print(f"완료 처리 요청: user_id={user_id}, id={id}, task={task}")
        
        # user_id 정규화 (user001 → user_001)
        if '_' not in user_id and user_id.startswith('user'):
            match = re.match(r'^user(\d+)$', user_id)
            if match:
                number = match.group(1)
                normalized_user_id = f"user_{number.zfill(3)}"
                print(f"user_id 정규화: {user_id} → {normalized_user_id}")
            else:
                normalized_user_id = user_id
        else:
            normalized_user_id = user_id
        
        # DB에서 해당 할일 찾기
        todo = db.query(Todo).filter(
            and_(
                Todo.user_id == normalized_user_id,
                Todo.id == id
            )
        ).first()
        
        if not todo:
            raise HTTPException(
                status_code=404,
                detail=f"할일을 찾을 수 없습니다: user_id={user_id}, id={id}"
            )
        
        print(f"기존 할일 정보: task={todo.task}, completed={todo.completed}")
        
        # 할일 정보 업데이트 (로컬 DB 동기화 + 완료 처리)
        todo.task = task  # 앱에서 수정된 최신 task로 업데이트
        todo.completed = True
        todo.completed_at = datetime.utcnow()
        todo.updated_at = datetime.utcnow()
        
        # DB 저장
        db.commit()
        db.refresh(todo)
        
        print(f"완료 처리 성공: id={id}, task={task}")
        
        # 완료된 할일 정보 반환
        return {
            "completed_todo": {
                "user_id": user_id,  # 원본 user_id 반환
                "id": todo.id,
                "todo": todo.task,
                "category": todo.category,
                "completed": todo.completed,
                "scheduled_date": todo.scheduled_date.strftime("%Y-%m-%d") if todo.scheduled_date else None,
                "completed_at": todo.completed_at.isoformat() + "Z" if todo.completed_at else None,
                "source": todo.source
            }
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"완료 처리 오류: {e}")
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"완료 처리 실패: {str(e)}"
        )