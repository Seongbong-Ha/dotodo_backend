from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # Database
    database_url: str
    
    # External Model APIs (환경변수에서 가져오기)
    model_parse_url: str
    model_reco_url: str
    
    # App Settings
    debug: bool = True
    log_level: str = "debug"
    
    class Config:
        env_file = ".env"

settings = Settings()