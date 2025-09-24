# import httpx  # 모델 서버 연동 시 사용 (현재 주석 처리)
import asyncio
from typing import List, Dict, Any
from datetime import datetime

class ModelService:
    def __init__(self):
        """모델 서비스 초기화"""
        # 외부 API 연동은 추후 활성화
        # self.recommendation_api_url = settings.model_reco_url  
        # self.parse_api_url = settings.model_parse_url
        print("✅ Mock 모델 서비스 초기화 완료 (외부 API 연동 준비 중)")
    
    async def get_recommendations(self, p_data: List[Dict], h_data: Dict) -> Dict[str, Any]:
        """추천 생성 - 현재는 Mock 데이터 반환"""
        
        # === 외부 모델 API 연동 (추후 활성화) ===
        # try:
        #     payload = {
        #         "p_data": p_data,  
        #         "h_data": h_data   
        #     }
        #     
        #     async with httpx.AsyncClient(timeout=30.0) as client:
        #         response = await client.post(
        #             f"{self.recommendation_api_url}/recommend",
        #             json=payload
        #         )
        #         response.raise_for_status()
        #         
        #         result = response.json()
        #         return result
        #         
        # except Exception as e:
        #     print(f"모델 API 오류: {e}")
        #     return self._get_mock_recommendations(h_data)
        
        # 현재는 Mock 데이터만 반환
        print("🔧 Mock 추천 데이터 생성 중...")
        
        # Pydantic 모델을 dict로 변환
        p_data_dict = []
        for item in p_data:
            if hasattr(item, 'dict'):  # Pydantic 모델인 경우
                p_data_dict.append(item.dict())
            else:  # 이미 dict인 경우
                p_data_dict.append(item)
        
        h_data_dict = h_data.dict() if hasattr(h_data, 'dict') else h_data
        
        return self._get_realistic_mock_recommendations(p_data_dict, h_data_dict)
    
    async def parse_voice_text(self, user_id: str, voice_text: str) -> List[Dict[str, Any]]:
        """음성 텍스트 파싱 - 현재는 Mock 데이터 반환"""
        
        # === 외부 모델 API 연동 (추후 활성화) ===
        # try:
        #     payload = {
        #         "user_id": user_id,
        #         "voice_text": voice_text
        #     }
        #     
        #     async with httpx.AsyncClient(timeout=30.0) as client:
        #         response = await client.post(
        #             f"{self.parse_api_url}/parse",
        #             json=payload
        #         )
        #         response.raise_for_status()
        #         
        #         result = response.json()
        #         return result.get("todos", [])
        #         
        # except Exception as e:
        #     print(f"파싱 API 오류: {e}")
        
        # 현재는 Mock 파싱 결과 반환
        print(f"🔧 Mock 파싱: '{voice_text}'")
        return self._get_mock_parsed_todos(voice_text)
    
    def _get_realistic_mock_recommendations(self, p_data: List[Dict], h_data: Dict) -> Dict[str, Any]:
        """현실적인 Mock 추천 데이터 생성"""
        
        # P데이터에서 자주 완료한 카테고리 분석 (Mock)
        category_counts = {}
        for day_data in p_data:
            for category, todos in day_data.get("completed_todos", {}).items():
                completed_count = len([t for t in todos if t.get("completed", False)])
                category_counts[category] = category_counts.get(category, 0) + completed_count
        
        # H데이터에서 미완료 작업 확인
        h_scheduled = h_data.get("scheduled_todos", {})
        incomplete_categories = []
        for category, todos in h_scheduled.items():
            incomplete_count = len([t for t in todos if not t.get("completed", False)])
            if incomplete_count > 0:
                incomplete_categories.append(category)
        
        print(f"📊 분석 결과 - 자주하는 카테고리: {category_counts}")
        print(f"📊 분석 결과 - 오늘 미완료 카테고리: {incomplete_categories}")
        
        # 카테고리별 Mock 추천 풀
        recommendation_pool = {
            "집안일": [
                "냉장고 정리하기", "화분 물주기", "침구 정리하기", "신발장 정리하기", 
                "서류 정리하기", "옷장 정리하기", "화장실 청소하기"
            ],
            "취업준비": [
                "이력서 온라인 제출하기", "면접 복장 준비하기", "자기소개 연습하기", 
                "포트폴리오 업데이트하기", "기업 리서치하기", "네트워킹 이벤트 찾기"
            ],
            "운동": [
                "요가 동영상 따라하기", "계단 오르내리기", "스트레칭 20분", 
                "동네 산책하기", "홈트레이닝 30분", "자전거 타기"
            ],
            "공부": [
                "온라인 강의 1시간", "전문 서적 읽기", "프로그래밍 연습하기", 
                "어학 공부하기", "자격증 문제 풀기", "논문 읽기"
            ],
            "자기계발": [
                "일기 쓰기", "명상 10분", "독서 30분", "팟캐스트 듣기", 
                "새로운 취미 찾기", "목표 점검하기", "감사 인사 보내기"
            ]
        }
        
        # Mock 추천 로직
        recommendations = []
        
        # 1. 자주 하는 카테고리에서 1개
        if category_counts:
            top_category = max(category_counts.items(), key=lambda x: x[1])[0]
            if top_category in recommendation_pool:
                recommendations.append({
                    "category": top_category,
                    "task": recommendation_pool[top_category][0],
                    "completed": False
                })
        
        # 2. 오늘 미완료 카테고리에서 1개 (다른 작업)
        for cat in incomplete_categories[:1]:
            if cat in recommendation_pool:
                recommendations.append({
                    "category": cat,
                    "task": recommendation_pool[cat][1],
                    "completed": False
                })
        
        # 3. 균형잡힌 추천으로 3개 맞추기
        if len(recommendations) < 3:
            remaining_categories = ["자기계발", "운동", "공부"]
            for cat in remaining_categories:
                if len(recommendations) >= 3:
                    break
                if cat not in [r["category"] for r in recommendations]:
                    recommendations.append({
                        "category": cat,
                        "task": recommendation_pool[cat][2],
                        "completed": False
                    })
        
        # 최대 3개로 제한
        recommendations = recommendations[:3]
        
        # 추천 이유 생성
        reason_parts = []
        for rec in recommendations:
            reason_parts.append(f"• {rec['category']} - {rec['task']}: 과거 패턴과 오늘 일정을 고려한 맞춤 추천")
        
        overall_reason = "오늘의 추천 할일들입니다:\n" + "\n".join(reason_parts)
        
        return {
            "recommendations": recommendations,
            "reason": overall_reason
        }
    
    def _get_mock_parsed_todos(self, voice_text: str) -> List[Dict[str, Any]]:
        """Mock 음성 파싱 결과"""
        
        # 간단한 키워드 기반 Mock 파싱
        mock_todos = []
        
        # 키워드별 매핑
        keyword_mappings = {
            "청소": {"category": "집안일", "task": "방 청소하기"},
            "빨래": {"category": "집안일", "task": "빨래하기"},
            "운동": {"category": "운동", "task": "운동하기"},
            "헬스": {"category": "운동", "task": "헬스장 가기"},
            "산책": {"category": "운동", "task": "산책하기"},
            "공부": {"category": "공부", "task": "공부하기"},
            "책": {"category": "공부", "task": "책 읽기"},
            "이력서": {"category": "취업준비", "task": "이력서 작성하기"},
            "면접": {"category": "취업준비", "task": "면접 준비하기"},
            "장보기": {"category": "집안일", "task": "장보기"},
            "마트": {"category": "집안일", "task": "마트 가기"}
        }
        
        # 키워드 매칭
        found_keywords = []
        for keyword, mapping in keyword_mappings.items():
            if keyword in voice_text:
                found_keywords.append(mapping)
        
        if found_keywords:
            mock_todos = found_keywords
        else:
            # 키워드가 없으면 원본 텍스트 그대로
            mock_todos = [{
                "category": "기타",
                "task": f"할 일: {voice_text}",
                "completed": False
            }]
        
        # completed 필드 추가
        for todo in mock_todos:
            todo["completed"] = False
        
        print(f"🔧 Mock 파싱 결과: {mock_todos}")
        return mock_todos
    
    def _get_mock_recommendations(self, h_data: Dict) -> Dict[str, Any]:
        """간단한 Mock 추천 (fallback용)"""
        return {
            "recommendations": [
                {"category": "집안일", "task": "책상 정리하기", "completed": False},
                {"category": "운동", "task": "스트레칭하기", "completed": False},
                {"category": "자기계발", "task": "일기 쓰기", "completed": False}
            ],
            "reason": "기본 Mock 추천입니다."
        }

# 싱글톤 인스턴스
_model_service = None

def get_model_service() -> ModelService:
    """모델 서비스 인스턴스 반환"""
    global _model_service
    if _model_service is None:
        _model_service = ModelService()
    return _model_service