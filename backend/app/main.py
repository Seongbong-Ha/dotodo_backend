from fastapi import FastAPI
from .routers import todos, recommendations

app = FastAPI(
    title="DoTodo API",
    description="음성을 할 일로 변환하는 API",
    version="1.0.0"
)

# 라우터 등록
app.include_router(todos.router)
app.include_router(recommendations.router)

@app.get("/")
def root():
    return {"message": "DoTodo API"}

@app.get("/health")
def health():
    return {"status": "healthy"}