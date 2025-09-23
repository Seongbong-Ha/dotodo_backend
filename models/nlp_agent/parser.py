import re
import json
from typing import Dict, Any, List
from mecab import MeCab
from datetime import datetime, timedelta

SENTENCE_SPLITTER = re.compile(r'([.?!])\s*|\n')

class Parser:
    def __init__(self):
        self.tokenizer = MeCab()
        print("Parser 초기화 완료: Mecab 엔진 사용")

    def _split_sentences(self, text: str) -> List[str]:
        sentences = [s.strip() for s in SENTENCE_SPLITTER.split(text) if s and s not in ['.', '?', '!']]
        return sentences

    def _get_absolute_date(self, relative_date: str) -> str:
        """
        '오늘', '내일', '주말' 등의 상대적 날짜를 YYYY-MM-DD 형식으로 변환합니다.
        """
        today = datetime.today()
        
        if relative_date == '오늘':
            return today.strftime('%Y-%m-%d')
        elif relative_date == '내일':
            tomorrow = today + timedelta(days=1)
            return tomorrow.strftime('%Y-%m-%d')
        elif relative_date == '주말':
            # 다음 주말(토요일)을 계산 (월요일이 한 주의 시작)
            days_until_saturday = (5 - today.weekday() + 7) % 7
            if days_until_saturday == 0: # 오늘이 토요일인 경우
                days_until_saturday = 7
            weekend_saturday = today + timedelta(days=days_until_saturday)
            return weekend_saturday.strftime('%Y-%m-%d')
        elif relative_date == '이번주':
            # 이번 주 월요일을 계산
            days_until_monday = today.weekday()
            this_monday = today - timedelta(days=days_until_monday)
            return this_monday.strftime('%Y-%m-%d')
        elif relative_date == '다음주':
            # 다음 주 월요일을 계산
            days_until_monday = (0 - today.weekday() + 7) % 7
            next_monday = today + timedelta(days=days_until_monday)
            return next_monday.strftime('%Y-%m-%d')
        else:
            return relative_date

    def _parse_single_sentence(self, sentence: str) -> Dict[str, Any]:
        print(f"\n[STEP 1] 원본 문장: '{sentence}'")
        
        parsed_tokens = self.tokenizer.pos(sentence)
        print(f"[STEP 2] Mecab 품사 태깅 결과: {parsed_tokens}")
        
        date = ""
        time = ""
        metadata_tokens = set()
        
        for i, (token, pos) in enumerate(parsed_tokens):
            if token in ['내일', '오늘', '이번주', '다음주', '주말']:
                date = self._get_absolute_date(token)
                metadata_tokens.add((token, pos))
            elif token in ['아침', '점심', '저녁', '오전', '오후', '새벽']:
                time = token
                metadata_tokens.add((token, pos))
            elif pos == 'SN':
                if i + 1 < len(parsed_tokens) and parsed_tokens[i+1][0] == '시':
                    time = f"{token}시"
                    metadata_tokens.add((token, pos))
                    metadata_tokens.add(parsed_tokens[i+1])
                elif '시' in sentence:
                    time = f"{token}시"
                    metadata_tokens.add((token, pos))
                else:
                    time = f"{token}"
                    metadata_tokens.add((token, pos))
        
        print(f"[STEP 3] 추출된 날짜: '{date}', 추출된 시간: '{time}'")
        print(f"[STEP 3] 메타데이터 토큰 튜플: {metadata_tokens}")
        
        todo_parts = []
        for token_tuple in parsed_tokens:
            token, pos = token_tuple
            if (token_tuple not in metadata_tokens) and (pos.startswith('NN') or pos.startswith('VV') or pos.startswith('VA')):
                todo_parts.append(token)
        
        todo = ' '.join(todo_parts)
        
        print("\n--- 파싱 결과 최종 확인 ---")
        print(f"Todo: '{todo}'")
        print(f"Date: '{date}'")
        print(f"Time: '{time}'")
        print("----------------------------\n")
        
        return {
            "todo": todo,
            "date": date,
            "time": time,
            "original_sentence": sentence
        }

    def parse_multiple_sentences(self, text: str) -> List[Dict[str, Any]]:
        print(f"전체 입력 텍스트: '{text}'")
        sentences = self._split_sentences(text)
        
        parsed_results = []
        last_known_date = ""
        
        for sentence in sentences:
            if not sentence:
                continue
                
            result = self._parse_single_sentence(sentence)
            
            if result['date']:
                last_known_date = result['date']
            elif last_known_date:
                result['date'] = last_known_date
            
            parsed_results.append(result)
                
        return parsed_results

if __name__ == "__main__":
    parser_instance = Parser()
    
    input_text = "내일 아침 헬스장에 가야 해. 그리고 오후 8시에 친구와 저녁 약속이 있어. 주말에는 집 근처 마트에서 장을 봐야지."
    parsed_list = parser_instance.parse_multiple_sentences(input_text)
    
    print("\n\n--- 최종 JSON 출력 ---")
    print(json.dumps(parsed_list, indent=4, ensure_ascii=False))