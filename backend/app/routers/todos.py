from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import date

from ..core.database import get_db
from ..schemas import TodoParseRequest, TodoParseResponse, TodoItem
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
        # 모델 서비스 호출 (async로 변경)
        model_service = get_model_service()
        todos_data = await model_service.parse_voice_text(  # 메서드명 수정 + await 추가
            user_id=request.user_id,
            voice_text=request.voice_text
        )
        
        # TodoItem 스키마로 변환
        todo_items = [TodoItem(**todo) for todo in todos_data]
        
        # 응답 생성
        response = TodoParseResponse(
            user_id=request.user_id,
            date=str(date.today()),
            todos=todo_items
        )
        
        # DB에 파싱된 할일들 저장 (선택사항)
        for todo_item in todo_items:
            db_todo = Todo(
                user_id=request.user_id,
                task=todo_item.task,
                category=todo_item.category,
                completed=todo_item.completed,
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
        raise HTTPException(status_code=500, detail=str(e))