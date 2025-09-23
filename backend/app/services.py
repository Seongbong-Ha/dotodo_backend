#import httpx
#import asyncio
import random
import os
from typing import List
from datetime import date

class MockModelService:
    """모델 API 대신 사용할 Mock 서비스"""
    
    @staticmethod
    def parse_voice_to_todos(user_id: str, voice_text: str) -> List[dict]:
        """음성 텍스트를 할 일 목록으로 변환 (Mock)"""
        
        mock_todos = []
        
        if "청소" in voice_text or "정리" in voice_text:
            mock_todos.append({
                "original_sentence": voice_text,
                "simplified_text": "방 청소하기",
                "category": "집안일",
                "date": "2025-09-24",
                "time": "오전",
                "embedding": [random.random() for _ in range(768)]
            })
        
        if "빨래" in voice_text:
            mock_todos.append({
                "original_sentence": voice_text,
                "simplified_text": "빨래하기", 
                "category": "집안일",
                "date": "2025-09-24",
                "time": "",
                "embedding": [random.random() for _ in range(768)]
            })
            
        if "운동" in voice_text or "헬스" in voice_text:
            mock_todos.append({
                "original_sentence": voice_text,
                "simplified_text": "헬스장 가기",
                "category": "운동", 
                "date": "2025-09-24",
                "time": "아침",
                "embedding": [random.random() for _ in range(768)]
            })
        
        if not mock_todos:
            mock_todos.append({
                "original_sentence": voice_text,
                "simplified_text": "할 일 정리",
                "category": "일상",
                "date": "2025-09-24", 
                "time": "",
                "embedding": [random.random() for _ in range(768)]
            })
            
        return mock_todos
    
    @staticmethod
    def get_recommendations(user_id: str) -> List[dict]:
        """사용자별 추천 생성 (Mock)"""
        return [
            {"category": "공부", "task": "프로그래밍 연습하기", "completed": False},
            {"category": "운동", "task": "산책하기", "completed": False},
            {"category": "집안일", "task": "책상 정리하기", "completed": False}
        ]

class ModelService:
    """실제 모델 API와 연결하는 서비스 (현재 주석 처리)"""
    
    def __init__(self):
        self.parse_url = os.getenv("MODEL_PARSE_URL")
        self.recommend_url = os.getenv("MODEL_RECO_URL")
    
    # 실제 모델 연결 시 활성화
    # async def parse_voice_to_todos(self, user_id: str, voice_text: str) -> List[dict]:
    #     """실제 NLP 모델 API 호출"""
    #     async with httpx.AsyncClient() as client:
    #         response = await client.post(
    #             self.parse_url,
    #             json={"user_id": user_id, "voice_text": voice_text},
    #             timeout=30.0
    #         )
    #         response.raise_for_status()
    #         return response.json()
    
    # async def get_recommendations(self, user_id: str) -> List[dict]:
    #     """실제 추천 모델 API 호출"""
    #     async with httpx.AsyncClient() as client:
    #         response = await client.post(
    #             self.recommend_url,
    #             json={"user_id": user_id},
    #             timeout=30.0
    #         )
    #         response.raise_for_status()
    #         return response.json()

# 현재는 Mock 서비스만 사용
USE_MOCK_SERVICE = True  # 나중에 환경변수로 변경: os.getenv("USE_MOCK_SERVICE", "true").lower() == "true"

def get_model_service():
    if USE_MOCK_SERVICE:
        return MockModelService()
    # else:
    #     return ModelService()