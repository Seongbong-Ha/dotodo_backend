import json
from typing import Dict, Any, List

# parser.py와 embedder.py 파일을 임포트
from parser import Parser
from embedder import TextEmbedder

class NLPAgent:
    def __init__(self):
        # 파서와 임베더 인스턴스 생성
        self.parser = Parser()
        self.embedder = TextEmbedder()
        print("\nNLPAgent 초기화 완료.")

    def process_text(self, text: str) -> List[Dict[str, Any]]:
        """
        입력 텍스트를 처리하여 TODO 항목들을 추출하고 임베딩을 생성합니다.
        
        Args:
            text (str): 사용자의 자연어 입력.
        
        Returns:
            List[Dict[str, Any]]: 처리된 TODO 항목들의 리스트.
        """
        # 1단계: Parser를 통해 문장 분리 및 메타데이터 추출
        parsed_todos = self.parser.parse_multiple_sentences(text)
        
        # 2단계: 각 TODO 항목에 대해 Embedder 실행
        for todo_item in parsed_todos:
            todo_text = todo_item.get('todo', '')
            if todo_text:
                # todo 텍스트를 임베더로 전달하여 변환 및 임베딩
                embed_result = self.embedder.embed_and_simplify(todo_text)
                
                # 변환된 텍스트와 임베딩을 결과에 추가
                todo_item['simplified_text'] = embed_result['simplified_text']
                # 임베딩은 NumPy 배열로 변환하여 저장
                todo_item['embedding'] = embed_result['embedding'].squeeze().tolist()
            else:
                todo_item['simplified_text'] = ''
                todo_item['embedding'] = []

        return parsed_todos

if __name__ == "__main__":
    agent = NLPAgent()

    input_text = "내일 아침 헬스장에 가야 해. 그리고 오후 8시에 친구와 저녁 약속이 있어. 주말에는 집 근처 마트에서 장을 봐야지."
    
    # 텍스트 처리 파이프라인 실행
    final_result = agent.process_text(input_text)

    print("\n\n--- 최종 통합 결과 ---")
    for idx, item in enumerate(final_result):
        print(f"** {idx + 1}. 원본 문장: '{item['original_sentence']}'")
        print(f"   - To-do (변환): '{item['simplified_text']}'")
        print(f"   - 날짜: '{item['date']}'")
        print(f"   - 시간: '{item['time']}'")
        print(f"   - 임베딩: [숨김] ({len(item['embedding'])}차원)")
        print("-" * 20)
    
    # 추가 테스트
    print("\n" + "="*50 + "\n")
    input_text_2 = "오늘 점심은 12시에 부대찌개 먹을거야."
    final_result_2 = agent.process_text(input_text_2)
    
    print("\n--- 추가 테스트 결과 ---")
    for idx, item in enumerate(final_result_2):
        print(f"** {idx + 1}. 원본 문장: '{item['original_sentence']}'")
        print(f"   - To-do (변환): '{item['simplified_text']}'")
        print(f"   - 날짜: '{item['date']}'")
        print(f"   - 시간: '{item['time']}'")
        print(f"   - 임베딩: [숨김] ({len(item['embedding'])}차원)")
        print("-" * 20)