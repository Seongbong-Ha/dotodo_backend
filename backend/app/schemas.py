from pydantic import BaseModel
from typing import List, Dict, Any, Optional
from datetime import date

# ====================
# TODO 파싱 관련 스키마
# ====================

class TodoParseRequest(BaseModel):
    """음성 텍스트 파싱 요청"""
    user_id: str
    text: str

class ParsedTodoItem(BaseModel):
    """파싱된 개별 할일 항목 (클라이언트 응답용)"""
    user_id: str
    todo: str
    date: str
    time: str
    original_sentence: str
    embedding: List[float]
    category: str

class TodoParseResponse(BaseModel):
    """음성 텍스트 파싱 응답"""
    success: bool
    todos: List[ParsedTodoItem]

# ====================
# 추천 관련 스키마
# ====================

class TodoItem(BaseModel):
    """기본 할일 항목"""
    task: str
    completed: bool

class PData(BaseModel):
    """지난 1주일 완료된 할일 데이터"""
    user_id: str
    date: str
    completed_todos: Dict[str, List[TodoItem]]

class HData(BaseModel):
    """오늘 예정된 할일 데이터"""
    user_id: str
    date: str
    scheduled_todos: Dict[str, List[TodoItem]]

class RecommendationRequest(BaseModel):
    """추천 요청"""
    p_data: List[PData]  # 지난 1주일 데이터 (배열)
    h_data: HData        # 오늘 데이터 (단일 객체)

class RecommendationItem(BaseModel):
    """추천 항목"""
    category: str
    task: str
    completed: bool = False

class RecommendationResponse(BaseModel):
    """추천 응답"""
    user_id: str
    date: str
    recommendations: List[RecommendationItem]
    reason: str