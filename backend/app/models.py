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
    accepted = Column(Boolean)
    created_at = Column(DateTime, default=datetime.utcnow)

class UserEvent(Base):
    __tablename__ = "user_events"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String(50), index=True, nullable=False)
    event_type = Column(String(100), nullable=False)
    target_type = Column(String(50))  # todo/recommendation
    target_id = Column(Integer)
    event_data = Column(JSONB)
    created_at = Column(DateTime, default=datetime.utcnow)

class SyncBatch(Base):
    __tablename__ = "sync_batches"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String(50), index=True, nullable=False)
    batch_id = Column(String(100), unique=True, nullable=False)
    records_synced = Column(Integer)
    sync_started_at = Column(DateTime)
    sync_completed_at = Column(DateTime)
    status = Column(String(20))  # SUCCESS/FAILED