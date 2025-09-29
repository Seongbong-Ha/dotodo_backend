import sys
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime, date
from sqlalchemy import and_
import re

from ..core.database import get_db
from ..schemas import RecommendationRequest, TodoParseRequest, TodoParseResponse, ParsedTodoItem
from ..services import get_model_service
from ..models import Todo

router = APIRouter(prefix="/api", tags=["todos"])

@router.post("/todos", response_model=TodoParseResponse)
async def parse_voice_to_todos(
    request: TodoParseRequest,
    db: Session = Depends(get_db)
):
    """음성 텍스트를 할 일 목록으로 분석"""
    try:
        # 모델 서비스 호출
        model_service = get_model_service()
        todos_data = await model_service.parse_voice_text(
            user_id=request.user_id,
            text=request.text
        )
        
        # DB에 저장하면서 ID를 받아오기
        saved_todos = []
        for todo_data in todos_data:
            # DB Todo 객체 생성
            db_todo = Todo(
                user_id=request.user_id,
                task=todo_data.get('todo'),
                category=todo_data.get('category'),
                completed=False,
                scheduled_date=date.today(),
                source="voice_parsing"
            )
            db.add(db_todo)
            db.flush()  # ID를 얻기 위해 flush
            
            # 모델 응답 데이터에 DB에서 생성된 ID 추가
            todo_data['id'] = db_todo.id
            saved_todos.append(ParsedTodoItem(**todo_data))
        
        try:
            db.commit()
        except Exception as db_error:
            print(f"DB 저장 오류: {db_error}")
            db.rollback()
            # DB 저장 실패시에도 모델 응답은 반환 (ID 없이)
            saved_todos = [ParsedTodoItem(**todo) for todo in todos_data]
        
        # 응답 생성 (ID 포함)
        return TodoParseResponse(
            success=True,
            todos=saved_todos
        )
        
    except Exception as e:
        print(f"파싱 오류: {e}")
        # 실패 시 success: false 반환
        return TodoParseResponse(
            success=False,
            todos=[]
        )
        

# 완료 처리 API
@router.put("/todos/complete")
async def complete_todo(
    user_id: str,
    id: int,
    task: str,
    db: Session = Depends(get_db)
):
    """
    할일 완료 처리
    
    Args:
        user_id: 사용자 ID
        id: 완료할 할일 ID  
        task: 최신 할일 내용 (로컬 DB에서 수정된 내용)
    
    Returns:
        완료 처리된 할일 정보
    """
    
    try:
        print(f"완료 처리 요청: user_id={user_id}, id={id}, task={task}")
        
        
        normalized_user_id = user_id
        
        # DB에서 해당 할일 찾기
        todo = db.query(Todo).filter(
            and_(
                Todo.user_id == normalized_user_id,
                Todo.id == id
            )
        ).first()
        
        if not todo:
            raise HTTPException(
                status_code=404,
                detail=f"할일을 찾을 수 없습니다: user_id={user_id}, id={id}"
            )
        
        print(f"기존 할일 정보: task={todo.task}, completed={todo.completed}")
        
        # 할일 정보 업데이트 (로컬 DB 동기화 + 완료 처리)
        todo.task = task  # 앱에서 수정된 최신 task로 업데이트
        todo.completed = True
        todo.completed_at = datetime.utcnow()
        todo.updated_at = datetime.utcnow()
        
        # DB 저장
        db.commit()
        db.refresh(todo)
        
        print(f"완료 처리 성공: id={id}, task={task}")
        
        # 완료된 할일 정보 반환
        return {
            "completed_todo": {
                "user_id": user_id,  # 원본 user_id 반환
                "id": todo.id,
                "todo": todo.task,
                "category": todo.category,
                "completed": todo.completed,
                "scheduled_date": todo.scheduled_date.strftime("%Y-%m-%d") if todo.scheduled_date else None,
                "completed_at": todo.completed_at.isoformat() + "Z" if todo.completed_at else None,
                "source": todo.source
            }
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"완료 처리 오류: {e}")
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"완료 처리 실패: {str(e)}"
        )
        
# 완료 취소 API
@router.put("/todos/uncomplete")
async def uncomplete_todo(
    user_id: str,
    id: int,
    task: str,
    db: Session = Depends(get_db)
):
    """
    할일 완료 취소 처리
    Args:
        user_id: 사용자 ID
        id: 완료 취소할 할일 ID  
        task: 최신 할일 내용 (로컬 DB에서 수정된 내용)
    
    Returns:
        완료 취소된 할일 정보
    """
    
    try:
        print(f"완료 취소 요청: user_id={user_id}, id={id}, task={task}")
        
        normalized_user_id = user_id
        
        # DB에서 해당 할일 찾기
        todo = db.query(Todo).filter(
            and_(
                Todo.user_id == normalized_user_id,
                Todo.id == id
            )
        ).first()
        
        if not todo:
            raise HTTPException(
                status_code=404,
                detail=f"할일을 찾을 수 없습니다: user_id={user_id}, id={id}"
            )
        
        print(f"기존 할일 정보: task={todo.task}, completed={todo.completed}")
        
        # 할일 정보 업데이트 (로컬 DB 동기화 + 완료 취소 처리)
        todo.task = task  # 앱에서 수정된 최신 task로 업데이트
        todo.completed = False  # 완료 취소
        todo.completed_at = None  # 완료 시간 제거
        todo.updated_at = datetime.utcnow()
        
        # DB 저장
        db.commit()
        db.refresh(todo)
        
        print(f"완료 취소 성공: id={id}, task={task}")
        
        # 완료 취소된 할일 정보 반환
        return {
            "completed_todo": {
                "id": todo.id,
                "user_id": user_id,  # 원본 user_id 반환
                "todo": todo.task,
                "category": todo.category,
                "completed": todo.completed,
                "scheduled_date": todo.scheduled_date.strftime("%Y-%m-%d") if todo.scheduled_date else None,
                "completed_at": todo.completed_at.isoformat() + "Z" if todo.completed_at else None,
                "source": todo.source
            }
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"완료 취소 오류: {e}")
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"완료 취소 실패: {str(e)}"
        )
        
# 삭제 처리 API
@router.delete("/todos/delete")
async def delete_todo(
    user_id: str,
    id: int,
    db: Session = Depends(get_db)
):
    """
    할일 삭제 처리
    
    Args:
        user_id: 사용자 ID
        id: 삭제할 할일 ID
    
    Returns:
        삭제 성공/실패 결과
    """
    
    try:
        print(f"삭제 요청: user_id={user_id}, id={id}")
        
       
        normalized_user_id = user_id
        
        # DB에서 해당 할일 찾기
        todo = db.query(Todo).filter(
            and_(
                Todo.user_id == normalized_user_id,
                Todo.id == id
            )
        ).first()
        
        if not todo:
            print(f"삭제할 할일을 찾을 수 없음: user_id={user_id}, id={id}")
            return {"success": "fail"}
        
        print(f"삭제할 할일 정보: task={todo.task}, completed={todo.completed}")
        
        # DB에서 할일 삭제
        db.delete(todo)
        db.commit()
        
        print(f"삭제 완료: id={id}")
        
        # 삭제 성공 응답
        return {"success": "success"}
        
    except Exception as e:
        print(f"삭제 오류: {e}")
        db.rollback()
        return {"success": "fail"}
    
    
# 추천 추가 API
@router.post("/todos/recommendations")
async def add_recommendations(
    request: RecommendationRequest,
    db: Session = Depends(get_db)
):
    """
    추천 할일을 실제 할일로 추가
    
    Args:
        request: 추천 추가 요청 데이터
    
    Returns:
        추가된 할일들의 정보
    """
    
    try:
        user_id = request.user_id
        recommendations = request.recommendations
        reason = request.reason
        
        print(f"추천 추가 요청: user_id={user_id}, {len(recommendations)}개 추천")
        
        # user_id 정규화 (user001 → user_001)
        if '_' not in user_id and user_id.startswith('user'):
            match = re.match(r'^user(\d+)$', user_id)
            if match:
                number = match.group(1)
                normalized_user_id = f"user_{number.zfill(3)}"
                print(f"user_id 정규화: {user_id} → {normalized_user_id}")
            else:
                normalized_user_id = user_id
        else:
            normalized_user_id = user_id
        
        added_todos = []
        
        # 각 추천을 할일로 변환해서 DB에 저장
        for i, rec in enumerate(recommendations):
            try:
                # 추천 데이터 파싱 (Pydantic 모델이므로 직접 접근)
                task = rec.task
                category = rec.category
                scheduled_date_str = rec.scheduled_date
                
                if not task:
                    print(f"빈 task 무시: {rec}")
                    continue
                
                # scheduled_date 파싱
                scheduled_date = None
                if scheduled_date_str:
                    try:
                        scheduled_date = datetime.strptime(scheduled_date_str, '%Y-%m-%d').date()
                    except ValueError:
                        print(f"잘못된 날짜 형식: {scheduled_date_str}")
                        scheduled_date = None
                
                # 새 Todo 생성
                new_todo = Todo(
                    user_id=normalized_user_id,
                    task=task,
                    category=category,
                    completed=False,
                    scheduled_date=scheduled_date,
                    source="recommendation",
                    created_at=datetime.utcnow(),
                    updated_at=datetime.utcnow()
                )
                
                db.add(new_todo)
                db.flush()  # ID를 얻기 위해 flush
                
                added_todos.append({
                    "id": new_todo.id,
                    "task": new_todo.task
                })
                
                print(f"추천 할일 추가 완료: id={new_todo.id}, task={task}")
                
            except Exception as rec_error:
                print(f"추천 처리 오류 (무시하고 계속): {rec_error}")
                continue
        
        # 모든 변경사항 커밋
        db.commit()
        
        if not added_todos:
            return {
                "success": "fail",
                "added": []
            }
        
        print(f"총 {len(added_todos)}개 추천 할일 추가 완료")
        
        return {
            "success": "success",
            "added": added_todos
        }
        
    except Exception as e:
        print(f"추천 추가 오류: {e}")
        db.rollback()
        return {
            "success": "fail", 
            "added": []
        }