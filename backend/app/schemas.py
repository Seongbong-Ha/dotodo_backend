from pydantic import BaseModel
from typing import List, Dict, Any, Optional
from datetime import date

class TodoItem(BaseModel):
    task: str
    completed: bool

class CompletedTodos(BaseModel):
    """지난 1주일 완료된 할일 (P데이터)"""
    집안일: Optional[List[TodoItem]] = []
    취업준비: Optional[List[TodoItem]] = []
    운동: Optional[List[TodoItem]] = []
    공부: Optional[List[TodoItem]] = []
    자기계발: Optional[List[TodoItem]] = []

class PData(BaseModel):
    """지난 1주일 완료된 할일 데이터"""
    user_id: str
    date: str
    completed_todos: Dict[str, List[TodoItem]]

class ScheduledTodos(BaseModel):
    """오늘 예정된 할일 (H데이터)"""
    집안일: Optional[List[TodoItem]] = []
    취업준비: Optional[List[TodoItem]] = []
    운동: Optional[List[TodoItem]] = []
    공부: Optional[List[TodoItem]] = []
    자기계발: Optional[List[TodoItem]] = []

class HData(BaseModel):
    """오늘 예정된 할일 데이터"""
    user_id: str
    date: str
    scheduled_todos: Dict[str, List[TodoItem]]

# 추천 요청 스키마 수정
class RecommendationRequest(BaseModel):
    """추천 요청"""
    p_data: List[PData]  # 지난 1주일 데이터 (배열 형태)
    h_data: HData        # 오늘 데이터 (단일 객체)

class RecommendationItem(BaseModel):
    """추천 항목"""
    category: str
    task: str
    completed: bool = False

# TodoItem은 RecommendationItem과 동일한 구조
TodoItem = RecommendationItem

class RecommendationResponse(BaseModel):
    """추천 응답"""
    user_id: str
    date: str
    recommendations: List[RecommendationItem]
    reason: str

# TODO 파싱 관련 스키마들 (원래 명세에 맞게 수정)
class TodoParseRequest(BaseModel):
    """TODO 파싱 요청"""
    user_id: str
    voice_text: str

class ParsedTodoItem(BaseModel):
    """파싱된 개별 할일 항목"""
    original_sentence: str
    todo: str
    category: str
    date: str
    time: str
    embedding: List[float]

class TodoParseResponse(BaseModel):
    """TODO 파싱 응답"""
    success: bool
    todos: List[ParsedTodoItem]

# 기존 스키마들과 호환성 유지
class TodoRequest(BaseModel):
    user_id: str
    voice_text: str

class TodoResponse(BaseModel):
    user_id: str
    date: str
    todos: List[RecommendationItem]