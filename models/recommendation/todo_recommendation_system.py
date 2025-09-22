import json
import re
import openai
import os
from dotenv import load_dotenv
from datetime import datetime
from typing import List, Dict, Any

class TodoRecommendationSystem:
    def __init__(self):
        load_dotenv()  # .env 파일 로드
        api_key = os.getenv('OPENAI_API_KEY')
        if not api_key:
            raise ValueError("OPENAI_API_KEY가 .env 파일에 설정되지 않았습니다.")
        openai.api_key = api_key
        self.client = openai.OpenAI(api_key=api_key)
    
    def load_json_file(self, filename: str) -> Any:
        """JSON 파일 로드"""
        try:
            with open(filename, 'r', encoding='utf-8') as f:
                return json.load(f)
        except FileNotFoundError:
            print(f"파일을 찾을 수 없습니다: {filename}")
            return None
        except json.JSONDecodeError:
            print(f"JSON 파싱 오류: {filename}")
            return None
    
    def filter_json_response(self, response: str) -> Dict[str, Any]:
        """LLM 응답에서 JSON 부분만 추출하고 파싱"""
        try:
            # JSON 부분만 정규식으로 추출
            json_match = re.search(r'\{.*\}', response, re.DOTALL)
            if json_match:
                json_str = json_match.group()
                return json.loads(json_str)
            else:
                print("JSON 형식을 찾을 수 없습니다.")
                return {}
        except json.JSONDecodeError as e:
            print(f"JSON 파싱 오류: {e}")
            return {}
        except Exception as e:
            print(f"기타 오류: {e}")
            return {}
    
    def call_gpt_first_recommendation(self, p_data: List[Dict], h_data: Dict) -> str:
        """첫 번째 GPT 호출 - 10-20개 추천"""
        prompt = f"""
사용자의 지난 1주일 완료된 할일과 오늘 예정된 할일을 분석해서 오늘 추가로 하면 좋을 할일 10-15개를 추천해주세요.

지난 1주일 완료된 할일:
{json.dumps(p_data, ensure_ascii=False, indent=2)}

오늘 예정된 할일:
{json.dumps(h_data, ensure_ascii=False, indent=2)}

**중요: 오늘 이미 예정된 할일과 중복되지 않는 새로운 할일만 추천해주세요.**

다음 카테고리에서 추천해주세요: 집안일, 취업준비, 운동, 공부, 자기계발

응답은 반드시 다음 JSON 형식으로만 주세요:
{{
    "recommendations": [
        {{"task": "할일명", "category": "카테고리", "reason": "추천이유"}},
        {{"task": "할일명", "category": "카테고리", "reason": "추천이유"}}
    ]
}}
"""
        
        try:
            response = self.client.chat.completions.create(
                model="gpt-4o-mini",  # GPT-5가 아직 없으므로 최신 모델 사용
                messages=[{"role": "user", "content": prompt}],
                temperature=0.7
            )
            return response.choices[0].message.content
        except Exception as e:
            print(f"GPT API 호출 오류: {e}")
            return ""
    
    def call_gpt_final_recommendation(self, p_data: List[Dict], h_data: Dict, first_recommendations: List[Dict]) -> str:
        """두 번째 GPT 호출 - 3개 최종 추천"""
        prompt = f"""
사용자의 완료된 할일과 오늘 예정된 할일, 그리고 첫 번째 추천 결과를 분석해서 가장 적합한 3개의 최종 추천을 선별해주세요.

지난 1주일 완료된 할일:
{json.dumps(p_data, ensure_ascii=False, indent=2)}

오늘 예정된 할일:
{json.dumps(h_data, ensure_ascii=False, indent=2)}

첫 번째 추천 결과:
{json.dumps(first_recommendations, ensure_ascii=False, indent=2)}

**중요: 오늘 이미 예정된 할일과 중복되지 않는 추천만 최종 선별해주세요.**

응답은 반드시 다음 JSON 형식으로만 주세요:
{{
    "final_recommendations": [
        {{"task": "할일명", "category": "카테고리", "reason": "추천이유"}},
        {{"task": "할일명", "category": "카테고리", "reason": "추천이유"}},
        {{"task": "할일명", "category": "카테고리", "reason": "추천이유"}}
    ]
}}
"""
        
        try:
            response = self.client.chat.completions.create(
                model="gpt-5-mini",
                messages=[{"role": "user", "content": prompt}],
                temperature=1
            )
            return response.choices[0].message.content
        except Exception as e:
            print(f"GPT API 호출 오류: {e}")
            return ""
    
    def generate_final_output(self, final_recommendations: List[Dict]) -> Dict[str, Any]:
        """최종 출력 JSON 생성"""
        recommendations_without_reason = []
        individual_reasons = []
    
        for rec in final_recommendations:
            recommendations_without_reason.append({
                "category": rec['category'],
                "task": rec['task'],
                "completed": False
            })
            individual_reasons.append(f"• {rec['category']} - {rec['task']}: {rec['reason']}")
    
        overall_reason = "오늘의 추천 할일들입니다:\n" + "\n".join(individual_reasons)

        final_output = {
         "user_id": "user001",
         "date": datetime.now().strftime("%Y-%m-%d"),
         "recommendations": recommendations_without_reason,
            "reason": overall_reason
        }
    
        return final_output
    
    def save_json_file(self, data: Dict, filename: str) -> None:
        """JSON 파일 저장"""
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
            print(f"✅ {filename} 파일이 저장되었습니다.")
        except Exception as e:
            print(f"파일 저장 오류: {e}")
    
    def run_recommendation_process(self) -> Dict[str, Any]:
        """전체 추천 프로세스 실행"""
        print("=== Todo 추천 시스템 시작 ===")
        
        # 1. 데이터 로드
        print("1. 데이터 로딩...")
        p_data = self.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_p_data.json')
        h_data = self.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_h_data.json')
        
        if not p_data or not h_data:
            print("❌ 데이터 로딩 실패")
            return {}
        
        print("✅ 데이터 로딩 완료")
        
        # 2. 첫 번째 추천
        print("\n2. 첫 번째 GPT 호출...")
        first_response = self.call_gpt_first_recommendation(p_data, h_data)
        if not first_response:
            print("❌ 첫 번째 GPT 호출 실패")
            return {}
        
        print("GPT 응답 (첫 200자):")
        print(first_response[:200] + "...")
        
        # 3. 첫 번째 필터링
        print("\n3. 첫 번째 응답 필터링...")
        first_filtered = self.filter_json_response(first_response)
        if not first_filtered or 'recommendations' not in first_filtered:
            print("❌ 첫 번째 필터링 실패")
            return {}
        
        print(f"✅ {len(first_filtered['recommendations'])}개 추천 추출")
        
        # 4. 두 번째 추천
        print("\n4. 두 번째 GPT 호출...")
        second_response = self.call_gpt_final_recommendation(p_data, h_data, first_filtered['recommendations'])
        if not second_response:
            print("❌ 두 번째 GPT 호출 실패")
            return {}
        
        print("GPT 응답 (첫 200자):")
        print(second_response[:200] + "...")
        
        # 5. 두 번째 필터링
        print("\n5. 두 번째 응답 필터링...")
        second_filtered = self.filter_json_response(second_response)
        if not second_filtered or 'final_recommendations' not in second_filtered:
            print("❌ 두 번째 필터링 실패")
            return {}
        
        print(f"✅ {len(second_filtered['final_recommendations'])}개 최종 추천 추출")
        
        # 6. 최종 출력 생성
        print("\n6. 최종 출력 생성...")
        final_output = self.generate_final_output(second_filtered['final_recommendations'])
        
        # 7. 파일 저장
        print("\n7. 결과 저장...")
        self.save_json_file(final_output, 'final_recommendations.json')
        
        print("\n=== 추천 시스템 완료 ===")
        return final_output
