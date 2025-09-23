from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import date

from ..core.database import get_db
from ..schemas import RecommendationRequest, RecommendationResponse, RecommendationItem
from ..services import get_model_service
from ..models import Recommendation

router = APIRouter(prefix="/api", tags=["recommendations"])

@router.post("/recommendations", response_model=RecommendationResponse)
async def get_recommendations(
    request: RecommendationRequest,
    db: Session = Depends(get_db)
):
    """사용자별 맞춤 추천 생성"""
    try:
        # 모델 서비스 호출
        model_service = get_model_service()
        recommendations_data = model_service.get_recommendations(request.user_id)
        
        # RecommendationItem 스키마로 변환
        recommendation_items = [RecommendationItem(**rec) for rec in recommendations_data]
        
        # 응답 생성
        response = RecommendationResponse(
            user_id=request.user_id,
            date=str(date.today()),
            recommendations=recommendation_items,
            reason="과거 데이터를 기반으로 한 맞춤형 추천입니다."
        )
        
        return response
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))