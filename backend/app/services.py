import httpx
from typing import List, Dict, Any
from .core.config import settings

class ModelService:
    def __init__(self):
        """모델 서비스 초기화"""
        self.stt_server_url = settings.model_parse_url
        self.recommendation_server_url = settings.model_reco_url
        print("ModelService 초기화 완료")
        print(f"- STT 서버: {self.stt_server_url}")
        print(f"- 추천 서버: {self.recommendation_server_url}")
    
    async def parse_voice_text(self, user_id: str, text: str) -> List[Dict[str, Any]]:
        """STT 모델 서버에서 음성 텍스트 파싱"""
        
        try:
            payload = {
                "user_id": user_id,
                "text": text
            }
            
            print(f"STT 서버로 요청 전송: {payload}")
            
            async with httpx.AsyncClient(timeout=30.0) as client:
                response = await client.post(
                    self.stt_server_url,
                    json=payload
                )
                response.raise_for_status()
                
                stt_result = response.json()
                print(f"STT 서버 응답: {stt_result}")
                
                # STT 응답에 user_id와 id 추가
                for i, item in enumerate(stt_result):
                    item["user_id"] = user_id
                    item["id"] = i + 1
                    item.pop("simplified_text", None)
                
                return stt_result
                
        except Exception as e:
            print(f"STT 서버 오류: {e}")
            raise Exception(f"STT 처리 실패: {e}")
    
    async def get_recommendations(self, p_data: List[Dict], h_data: Dict) -> Dict[str, Any]:
        """레거시 추천 함수 - Mock 데이터 반환"""
        print("Mock 추천 데이터 반환")
        
        return {
            "recommendations": [
                {"category": "운동", "task": "스트레칭하기", "completed": False},
                {"category": "공부", "task": "책 읽기", "completed": False},
                {"category": "일상", "task": "정리하기", "completed": False}
            ],
            "reason": "Mock 추천 데이터입니다."
        }

# 싱글톤 인스턴스
_model_service = None

def get_model_service() -> ModelService:
    """모델 서비스 인스턴스 반환"""
    global _model_service
    if _model_service is None:
        _model_service = ModelService()
    return _model_service