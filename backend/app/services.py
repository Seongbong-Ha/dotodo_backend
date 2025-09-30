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
                print(f"STT 서버 응답 타입: {type(stt_result)}")
                
                # 응답 형식 정규화
                if isinstance(stt_result, dict):
                    # 딕셔너리인 경우 - 여러 가능성 처리
                    if 'todos' in stt_result or 'results' in stt_result:
                        # {"todos": [...]} 또는 {"results": [...]} 형태
                        stt_result = stt_result.get('todos') or stt_result.get('results', [])
                    else:
                        # 단일 할일이 딕셔너리로 온 경우
                        stt_result = [stt_result]
                    print(f"딕셔너리 응답을 리스트로 변환: {len(stt_result)}개 항목")
                elif isinstance(stt_result, list):
                    # 이미 리스트인 경우 - 그대로 사용
                    print(f"리스트 응답: {len(stt_result)}개 항목")
                else:
                    print(f"❌ STT 서버 응답 형식 오류: {type(stt_result)}")
                    print(f"실제 응답: {stt_result}")
                    raise Exception(f"STT 서버 응답 형식 오류: 지원하지 않는 {type(stt_result)} 타입")
                
                # STT 응답에 user_id와 id 추가
                for i, item in enumerate(stt_result):
                    if isinstance(item, dict):
                        item["user_id"] = user_id
                        item["id"] = i + 1
                        item.pop("simplified_text", None)
                    else:
                        print(f"⚠️ STT 응답 항목이 dict가 아닙니다: {type(item)} - {item}")
                
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