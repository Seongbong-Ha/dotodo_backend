FROM python:3.11-slim

WORKDIR /app

# 의존성 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 앱 복사
COPY . .

# Streamlit 실행
CMD ["streamlit", "run", "app.py", "--server.address", "0.0.0.0"]
