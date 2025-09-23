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
        # 모델 서비스 호출
        model_service = get_model_service()
        todos_data = model_service.parse_voice_to_todos(
            request.user_id, 
            request.voice_text
        )
        
        # TodoItem 스키마로 변환
        todo_items = [TodoItem(**todo) for todo in todos_data]
        
        # 응답 생성
        response = TodoParseResponse(
            user_id=request.user_id,
            date=str(date.today()),
            todos=todo_items
        )
        
        return response
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))