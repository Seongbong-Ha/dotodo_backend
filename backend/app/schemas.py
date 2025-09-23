from pydantic import BaseModel
from typing import List, Optional
from datetime import date

# API 입력 스키마
class TodoParseRequest(BaseModel):
    user_id: str
    voice_text: str

class RecommendationRequest(BaseModel):
    user_id: str

# API 출력 스키마 - 상세형식
class TodoItem(BaseModel):
    original_sentence: str
    simplified_text: str
    category: str
    date: Optional[str] = None  # YYYY-MM-DD 형식
    time: Optional[str] = None  # "아침", "저녁" 등
    embedding: List[float]      # 768차원 벡터

class TodoParseResponse(BaseModel):
    user_id: str
    date: str  # API 호출 날짜
    todos: List[TodoItem]

# 추천 API는 기본 형식 유지
class RecommendationItem(BaseModel):
    category: str
    task: str
    completed: bool

class RecommendationResponse(BaseModel):
    user_id: str
    date: str
    recommendations: List[RecommendationItem]
    reason: str