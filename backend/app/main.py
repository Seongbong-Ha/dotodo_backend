from fastapi import FastAPI

app = FastAPI(title="dotodo API", version="1.0.0")

@app.get("/")
def read_root():
    return {"message": "dotodo API is running!"}