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
    id: Optional[int] = None
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
# 추천 관련 스키마 (간소화) - NEW
# ====================

class SimpleRecommendationRequest(BaseModel):
    """간단한 추천 요청 (user_id만 필요)"""
    user_id: str
    base_date: Optional[str] = None  # 기준 날짜 (기본값: 오늘)

    class Config:
        schema_extra = {
            "example": {
                "user_id": "user001",
                "base_date": "2025-09-25"
            }
        }

class RecommendationItem(BaseModel):
    """추천 항목"""
    recommendation_id: Optional[int] = None
    category: str
    task: str  # 모델 서버 응답에서 'task' 또는 'todo' 필드 지원
    scheduled_date: Optional[str] = None
    completed: bool = False

    class Config:
       json_schema_extra = {
            "example": {
                "recommendation_id": 123,
                "category": "운동",
                "task": "스트레칭하기",
                "scheduled_date": "2025-09-30",
                "completed": False
            }
        }

class RecommendationResponse(BaseModel):
    """추천 응답"""
    user_id: str
    date: str
    recommendations: List[RecommendationItem]
    reason: str

    class Config:
        schema_extra = {
            "example": {
                "user_id": "user001",
                "date": "2025-09-25",
                "recommendations": [
                    {
                        "category": "운동",
                        "task": "스트레칭하기",
                        "completed": False
                    },
                    {
                        "category": "공부",
                        "task": "영어 단어 암기",
                        "completed": False
                    }
                ],
                "reason": "과거 패턴을 보면 **운동**과 **공부**를 꾸준히 하시는 편이에요."
            }
        }

# ====================
# 레거시 스키마 (기존 클라이언트 호환용)
# ====================

class TodoItem(BaseModel):
    """기본 할일 항목 (레거시 호환용)"""
    todo: str  # DB 모델의 task 필드와 매칭 (레거시에서는 todo 사용)
    completed: bool

    class Config:
        schema_extra = {
            "example": {
                "todo": "운동하기",
                "completed": True
            }
        }

class PData(BaseModel):
    """지난 1주일 완료된 할일 데이터 (레거시)"""
    user_id: str
    date: str
    completed_todos: Dict[str, List[TodoItem]]

class HData(BaseModel):
    """오늘 예정된 할일 데이터 (레거시)"""
    user_id: str
    date: str
    scheduled_todos: Dict[str, List[TodoItem]]

class LegacyRecommendationRequest(BaseModel):
    """레거시 추천 요청 (클라이언트가 데이터 직접 전송)"""
    p_data: List[PData]  # 지난 1주일 데이터 (배열)
    h_data: HData        # 오늘 데이터 (단일 객체)

class RecommendationItem(BaseModel):
    task: str
    category: str
    scheduled_date: str

class RecommendationRequest(BaseModel):
    user_id: str
    recommendations: List[RecommendationItem]
    reason: Optional[str] = ""

    class Config:
        schema_extra = {
            "example": {
                "user_id": "user001",
                "recommendations": [
                    {
                        "task": "프로그래밍 연습하기",
                        "category": "공부",
                        "scheduled_date": "2025-09-24"
                    },
                    {
                        "task": "스트레칭하기",
                        "category": "운동",
                        "scheduled_date": "2025-09-24"
                    }
                ],
                "reason": "전체 추천에 대한 종합 설명"
            }
        }

