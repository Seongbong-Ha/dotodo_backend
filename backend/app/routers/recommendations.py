from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
import httpx
import re
from typing import Dict, Any

from ..core.database import get_db
from ..core.config import settings
from ..utils.test_service import prepare_recommendation_data
from ..models import Recommendation

router = APIRouter(prefix="/api", tags=["recommendations"])


def normalize_user_id(user_id: str) -> str:
    """
    user_id 형식을 DB 형식으로 정규화
    
    Examples:
        user001 → user_001
        user123 → user_123
        user_001 → user_001 (이미 올바른 형식)
    """
    if not user_id or not user_id.startswith('user'):
        return user_id
    
    # 이미 언더스코어가 있으면 그대로 반환
    if '_' in user_id:
        return user_id
    
    # user001 → user_001 변환
    match = re.match(r'^user(\d+)$', user_id)
    if match:
        number = match.group(1)
        normalized = f"user_{number.zfill(3)}"  # 3자리로 패딩
        print(f"🔄 user_id 정규화: {user_id} → {normalized}")
        return normalized
    
    return user_id


@router.post("/recommendations")
async def get_recommendations(
    user_id: str,
    base_date: str = None,
    db: Session = Depends(get_db)
):
    """
    사용자별 맞춤 추천 생성
    
    Args:
        user_id: 사용자 ID (예: "user001" 또는 "user_001")
        base_date: 기준 날짜 (예: "2025-09-25", 기본값: 오늘)
    
    Returns:
        모델 서버에서 받은 추천 결과
    """
    
    print(f"🎯 추천 요청: user_id={user_id}, base_date={base_date}")
    
    try:
        # 1. user_id 정규화 (user001 → user_001)
        normalized_user_id = normalize_user_id(user_id)
        
        # 2. DB에서 P_DATA, H_DATA 조회 및 JSON 생성
        print(f"📊 DB 데이터 조회: {normalized_user_id}")
        json_data = prepare_recommendation_data(normalized_user_id, base_date)
        
        if not json_data or not json_data.get('p_data') or not json_data.get('h_data'):
            raise HTTPException(
                status_code=404,
                detail=f"사용자 {user_id}의 데이터가 부족합니다. 과거 할일 기록을 확인하세요."
            )
        
        print(f"✅ JSON 데이터 생성 완료")
        print(f"   - P_DATA: {len(json_data['p_data'])}일")
        print(f"   - H_DATA: {sum(len(todos) for todos in json_data['h_data'].get('scheduled_todos', {}).values())}개 할일")
        
        # 3. 모델 서버로 API 요청
        model_api_url = settings.model_reco_url
        print(f"📡 모델 서버 요청: {model_api_url}")
        
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.post(
                model_api_url,
                json=json_data,
                headers={"Content-Type": "application/json"}
            )
            
            print(f"📊 모델 서버 응답: {response.status_code}")
            
            if response.status_code != 200:
                print(f"❌ 모델 서버 오류: {response.text}")
                raise HTTPException(
                    status_code=response.status_code,
                    detail=f"모델 서버 오류 ({response.status_code}): {response.text}"
                )
            
            model_result = response.json()
            print(f"✅ 모델 서버 응답 성공")
        
        # 4. DB에 추천 결과 저장 (로깅용)
        try:
            recommendations = model_result.get('recommendations', [])
            if recommendations:
                print(f"💾 DB에 추천 결과 저장: {len(recommendations)}개")
                for rec in recommendations:
                    task_text = rec.get('task') or rec.get('todo', '')
                    if task_text:
                        db_recommendation = Recommendation(
                            user_id=normalized_user_id,
                            recommended_task=task_text,
                            category=rec.get('category', '기타'),
                            reason=model_result.get('reason', '맞춤형 추천')
                        )
                        db.add(db_recommendation)
                
                db.commit()
                print(f"✅ DB 저장 완료")
        except Exception as db_error:
            print(f"⚠️ DB 저장 오류 (무시): {db_error}")
            db.rollback()
        
        # 5. 모델 서버 응답 반환
        print(f"🎉 추천 완료: {user_id}")
        return model_result
        
    except HTTPException:
        # FastAPI HTTPException은 그대로 전달
        raise
    except httpx.ConnectError as e:
        print(f"❌ 모델 서버 연결 실패: {e}")
        raise HTTPException(
            status_code=503,
            detail=f"모델 서버에 연결할 수 없습니다: {model_api_url}"
        )
    except httpx.TimeoutException as e:
        print(f"❌ 모델 서버 타임아웃: {e}")
        raise HTTPException(
            status_code=504,
            detail="모델 서버 응답 시간이 초과되었습니다 (30초)"
        )
    except Exception as e:
        print(f"❌ 예상치 못한 오류: {e}")
        raise HTTPException(
            status_code=500,
            detail=f"추천 생성 실패: {str(e)}"
        )