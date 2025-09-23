import json
import re
import os
from datetime import datetime
from typing import List, Dict, Any

from dotenv import load_dotenv
from langchain.prompts import PromptTemplate
from langchain_openai import ChatOpenAI
from langchain_core.output_parsers import BaseOutputParser
from langchain_community.callbacks import get_openai_callback

class JSONOutputParser(BaseOutputParser):
    """JSON 출력을 강제로 파싱하는 커스텀 파서"""
    
    def parse(self, text: str) -> Dict[str, Any]:
        """텍스트에서 JSON 부분을 추출하고 파싱"""
        try:
            # 방법 1: 첫 번째 { 부터 마지막 } 까지
            start_idx = text.find('{')
            end_idx = text.rfind('}')
            
            if start_idx != -1 and end_idx != -1 and end_idx > start_idx:
                json_str = text[start_idx:end_idx+1]
                return json.loads(json_str)
            
            # 방법 2: 정규식으로 JSON 블록 추출
            json_match = re.search(r'\{.*\}', text, re.DOTALL)
            if json_match:
                json_str = json_match.group()
                return json.loads(json_str)
            
            raise ValueError("JSON 형식을 찾을 수 없습니다.")
            
        except json.JSONDecodeError as e:
            raise ValueError(f"JSON 파싱 오류: {e}")
    
    def get_format_instructions(self) -> str:
        return "응답은 반드시 유효한 JSON 형식으로만 주세요."

class LangChainTodoRecommendationSystem:
    def __init__(self):
        load_dotenv()
        api_key = os.getenv('OPENAI_API_KEY')
        if not api_key:
            raise ValueError("OPENAI_API_KEY가 .env 파일에 설정되지 않았습니다.")
        
        # ChatOpenAI 사용 (최신 권장 방식)
        self.llm = ChatOpenAI(
            openai_api_key=api_key,
            model_name="gpt-5-mini",
            temperature=1
        )
        
        # JSON 파서 초기화 (단순화)
        self.json_parser = JSONOutputParser()
        
        # 프롬프트 템플릿들 초기화
        self._setup_prompt_templates()
        
        # 체인 구성 (최신 방식)
        self._setup_chains()
    
    def _setup_prompt_templates(self):
        """프롬프트 템플릿 설정"""
        
        # 첫 번째 프롬프트 템플릿 (초기 추천)
        self.first_prompt_template = PromptTemplate(
            input_variables=["p_data", "h_data"],
            template="""
Analyze the user's completed tasks from the past week and today's scheduled tasks to recommend 10 additional tasks for today.

Past week completed tasks:
{p_data}

Today's scheduled tasks:
{h_data}

**Important: Only recommend NEW tasks that don't overlap with today's scheduled tasks.**
**Task names should NOT include time/location info in parentheses.**

Recommend from these categories: 운동, 공부, 장보기, 업무, 일상, 기타

{format_instructions}

Respond in this JSON format:
{{
    "recommendations": [
        {{"task": "task_name", "category": "category", "reason": "recommendation_reason"}},
        {{"task": "task_name", "category": "category", "reason": "recommendation_reason"}}
    ]
}}
"""
        )
        
        # 두 번째 프롬프트 템플릿 (최종 선별)
        self.second_prompt_template = PromptTemplate(
            input_variables=["p_data", "h_data", "first_recommendations"],
            template="""
Select the 3 most suitable final recommendations from the analysis of completed tasks, scheduled tasks, and initial recommendations.

Past week completed tasks:
{p_data}

Today's scheduled tasks:
{h_data}

Initial recommendations:
{first_recommendations}

**Important: Only select recommendations that don't overlap with scheduled tasks.**
**Task names should NOT include time/location info in parentheses.**

Korean response rules for 'reason':
- One sentence per recommended task
- Use warm, encouraging tone (e.g., "도움이 될 거예요", "좋을 것 같아요")
- Bold important keywords using **word** format
- No dashes(-), colons(:), bullet points, or order indicators
- No opening phrases like "오늘의 추천 할일입니다"

Respond in Korean using this JSON format:
{{
    "final_recommendations": [
        {{"task": "할일명", "category": "카테고리"}},
        {{"task": "할일명", "category": "카테고리"}},
        {{"task": "할일명", "category": "카테고리"}}
    ],
    "reason": "할일1에 대한 **핵심 이유**로 도움이 될 거예요. 할일2는 **중요한 부분** 때문에 추천드려요. 할일3을 하시면 **강조할 내용**으로 좋을 것 같아요."
}}
"""
        )
    
    def _setup_chains(self):
        """현대적인 LangChain 방식으로 체인 설정"""
        
        # 첫 번째 체인 (현대적 방식)
        self.first_chain = self.first_prompt_template | self.llm | self.json_parser
        
        # 두 번째 체인 (현대적 방식)
        self.second_chain = self.second_prompt_template | self.llm | self.json_parser
    
    def load_json_file(self, filename: str) -> Any:
        """JSON 파일 로드 (기존 방식 유지)"""
        try:
            with open(filename, 'r', encoding='utf-8') as f:
                return json.load(f)
        except FileNotFoundError:
            print(f"파일을 찾을 수 없습니다: {filename}")
            return None
        except json.JSONDecodeError:
            print(f"JSON 파싱 오류: {filename}")
            return None
    
    def save_json_file(self, data: Dict, filename: str) -> None:
        """JSON 파일 저장 (기존 방식 유지)"""
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
            print(f"✅ {filename} 파일이 저장되었습니다.")
        except Exception as e:
            print(f"파일 저장 오류: {e}")
    
    def generate_final_output(self, second_result: Dict) -> Dict[str, Any]:
        """최종 출력 JSON 생성 (새로운 구조)"""
        
        # final_recommendations에서 task와 category만 추출
        recommendations_without_reason = []
        
        for rec in second_result['final_recommendations']:
            recommendations_without_reason.append({
                "category": rec['category'],
                "task": rec['task'],
                "completed": False
            })
        
        # reason을 그대로 사용
        overall_reason = second_result.get('reason', '추천 이유를 가져올 수 없습니다.')
    
        final_output = {
            "user_id": "user001",
            "date": datetime.now().strftime("%Y-%m-%d"),
            "recommendations": recommendations_without_reason,
            "reason": overall_reason
        }
    
        return final_output
    
    def run_recommendation_process(self) -> Dict[str, Any]:
        """전체 추천 프로세스 실행 (단순화된 접근법)"""
        print("=== LangChain Todo 추천 시스템 시작 ===")
        
        # 1. 데이터 로드
        print("1. 데이터 로딩...")
        p_data = self.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_p_data.json')
        h_data = self.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_h_data.json')
        
        if not p_data or not h_data:
            print("❌ 데이터 로딩 실패")
            return {}
        
        print("✅ 데이터 로딩 완료")
        
        # 2. 데이터 포맷팅
        p_data_str = json.dumps(p_data, ensure_ascii=False, indent=2)
        h_data_str = json.dumps(h_data, ensure_ascii=False, indent=2)
        format_instructions = self.json_parser.get_format_instructions()
        
        # 3. 첫 번째 체인 실행
        print("\n2. 첫 번째 추천 체인 실행 중...")
        
        try:
            with get_openai_callback() as cb:
                first_result = self.first_chain.invoke({
                    "p_data": p_data_str,
                    "h_data": h_data_str,
                    "format_instructions": format_instructions
                })
                print(f"✅ 첫 번째 체인 완료 - 토큰 사용: {cb.total_tokens}")
        
        except Exception as e:
            print(f"❌ 첫 번째 체인 실행 오류: {e}")
            return {}
        
        # 4. 첫 번째 결과 저장
        if first_result:
            self.save_json_file(first_result, 'first_recommendations.json')
            print(f"✅ 첫 번째 추천 {len(first_result.get('recommendations', []))}개 추출")
        else:
            print("❌ 첫 번째 추천 결과 없음")
            return {}
        
        # 5. 두 번째 체인 실행
        print("\n3. 두 번째 추천 체인 실행 중...")
        first_recommendations_str = json.dumps(first_result, ensure_ascii=False, indent=2)
        
        try:
            with get_openai_callback() as cb:
                second_result = self.second_chain.invoke({
                    "p_data": p_data_str,
                    "h_data": h_data_str,
                    "first_recommendations": first_recommendations_str,
                    "format_instructions": format_instructions
                })
                print(f"✅ 두 번째 체인 완료 - 토큰 사용: {cb.total_tokens}")
        
        except Exception as e:
            print(f"❌ 두 번째 체인 실행 오류: {e}")
            return {}
        
        # 6. 최종 결과 처리
        if not second_result or 'final_recommendations' not in second_result:
            print("❌ 최종 추천 추출 실패")
            return {}
        
        print(f"✅ 최종 추천 {len(second_result['final_recommendations'])}개 추출")
        
        # 7. 최종 출력 생성
        print("\n4. 최종 출력 생성...")
        final_output = self.generate_final_output(second_result)
        
        # 8. 파일 저장
        print("\n5. 결과 저장...")
        self.save_json_file(final_output, 'final_recommendations.json')
        
        print("\n=== LangChain 추천 시스템 완료 ===")
        return final_output