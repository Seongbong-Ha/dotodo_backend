FROM python:3.11-slim

WORKDIR /usr/app

# PostgreSQL 클라이언트 설치
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql-client \
    git \
    && rm -rf /var/lib/apt/lists/*

# dbt-postgres 최신 버전 설치
RUN pip install --no-cache-dir \
    dbt-postgres==1.9.0

# 작업 디렉토리 복사
COPY . /usr/app

# 컨테이너 유지
CMD ["tail", "-f", "/dev/null"]