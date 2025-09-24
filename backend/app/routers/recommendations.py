from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import date
from typing import List, Dict, Any

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
        # 모델 서비스 호출 - P데이터와 H데이터를 함께 전달
        model_service = get_model_service()
        recommendations_data = await model_service.get_recommendations(
            p_data=request.p_data,  # 지난 1주일 완료된 할일
            h_data=request.h_data   # 오늘 예정된 할일
        )
        
        # RecommendationItem 스키마로 변환
        recommendation_items = [RecommendationItem(**rec) for rec in recommendations_data["recommendations"]]
        
        # 응답 생성 - H데이터에서 user_id 추출
        response = RecommendationResponse(
            user_id=request.h_data.user_id,  # Dict 접근 방식에서 attribute 접근 방식으로 변경
            date=str(date.today()),
            recommendations=recommendation_items,
            reason=recommendations_data.get("reason", "과거 데이터를 기반으로 한 맞춤형 추천입니다.")
        )
        
        # DB에 추천 결과 저장 (선택사항)
        for rec in recommendation_items:
            db_recommendation = Recommendation(
                user_id=response.user_id,
                recommended_task=rec.task,
                category=rec.category,
                reason=response.reason
            )
            db.add(db_recommendation)
        
        try:
            db.commit()
        except Exception as db_error:
            print(f"DB 저장 오류 (무시하고 계속): {db_error}")
            db.rollback()
        
        return response
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))