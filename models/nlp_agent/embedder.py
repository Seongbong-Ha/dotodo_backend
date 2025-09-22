import torch
from transformers import AutoTokenizer, AutoModel
from typing import List, Dict
from mecab import MeCab

class TextEmbedder:
    def __init__(self, model_name: str = "jhgan/ko-sroberta-multitask"):
        print(f"임베딩 모델 로딩 중: {model_name}")
        self.tokenizer = AutoTokenizer.from_pretrained(model_name)
        self.model = AutoModel.from_pretrained(model_name)
        self.mecab = MeCab()
        
        self.device = torch.device('cpu')
        self.model.to(self.device)
        self.model.eval()
        print("임베딩 모델 로딩 완료.")

    def _mean_pooling(self, model_output, attention_mask):
        token_embeddings = model_output[0]
        input_mask_expanded = attention_mask.unsqueeze(-1).expand(token_embeddings.size()).float()
        return torch.sum(token_embeddings * input_mask_expanded, 1) / torch.clamp(input_mask_expanded.sum(1), min=1e-9)
    
    def _simplify_todo_text(self, text: str) -> str:
        """
        Mecab 품사 정보를 활용하여 텍스트에서 명사만 추출합니다.
        """
        parsed_tokens = self.mecab.pos(text)
        
        simplified_parts = []
        
        for token, pos in parsed_tokens:
            if pos.startswith('NN'): # 명사
                simplified_parts.append(token)
            # 동사, 형용사, 기타 품사는 제외
        
        # 추출된 명사들을 공백으로 연결
        simplified_text = ' '.join(simplified_parts).strip()
        
        return simplified_text

    def embed_and_simplify(self, text: str) -> Dict[str, any]:
        simplified_text = self._simplify_todo_text(text)
        
        encoded_input = self.tokenizer(simplified_text, padding=True, truncation=True, return_tensors='pt').to(self.device)
        
        with torch.no_grad():
            model_output = self.model(**encoded_input)
        
        sentence_embeddings = self._mean_pooling(model_output, encoded_input['attention_mask'])
        
        sentence_embeddings = torch.nn.functional.normalize(sentence_embeddings, p=2, dim=1)
        
        return {
            "simplified_text": simplified_text,
            "embedding": sentence_embeddings.cpu()
        }

if __name__ == "__main__":
    embedder = TextEmbedder()
    
    input_text = "매일 아침 7시에는 아침 먹기 전에 헬스장에 가야 해."
    result = embedder.embed_and_simplify(input_text)
    
    print("\n--- 결과 확인 ---")
    print(f"원본 텍스트: '{input_text}'")
    print(f"변환된 텍스트: '{result['simplified_text']}'")
    print("임베딩 벡터 모양:", result['embedding'].shape)
    
    print("\n--- 추가 테스트 ---")
    input_text_2 = "그리고 오후 8시에 고등학교 동창과 저녁 약속이 있어."
    result_2 = embedder.embed_and_simplify(input_text_2)
    print(f"원본 텍스트: '{input_text_2}'")
    print(f"변환된 텍스트: '{result_2['simplified_text']}'")
    print("임베딩 벡터 모양:", result_2['embedding'].shape)
