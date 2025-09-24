from sqlalchemy import Column, Integer, String, Boolean, Date, DateTime, Text
from sqlalchemy.dialects.postgresql import JSONB
from datetime import datetime
from .core.database import Base

class Todo(Base):
    __tablename__ = "todos"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String(50), index=True, nullable=False)
    task = Column(String(500), nullable=False)
    category = Column(String(100))
    completed = Column(Boolean, default=False)
    scheduled_date = Column(Date)
    completed_at = Column(DateTime)
    source = Column(String(20))  # STT/recommendation
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

class Recommendation(Base):
    __tablename__ = "recommendations"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String(50), index=True, nullable=False)
    recommended_task = Column(String(500), nullable=False)
    category = Column(String(100))
    reason = Column(Text)
    accepted = Column(Boolean)  # 사용자 수락 여부
    created_at = Column(DateTime, default=datetime.utcnow)

class UserEvent(Base):
    __tablename__ = "user_events"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String(50), index=True, nullable=False)
    event_type = Column(String(100), nullable=False)
    target_type = Column(String(50))  # todo/recommendation
    target_id = Column(Integer)
    event_data = Column(JSONB)  # 이벤트 상세 데이터
    created_at = Column(DateTime, default=datetime.utcnow)