#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
from todo_recommendation_system import LangChainTodoRecommendationSystem

def run_langchain_test():
    """LangChain 기반 전체 테스트"""
    print("=== LangChain Todo 추천 시스템 테스트 시작 ===")
    print("=" * 60)
    
    try:
        # 시스템 초기화
        print("시스템 초기화 중...")
        system = LangChainTodoRecommendationSystem()
        print("✅ LangChain 시스템 초기화 완료")
        
        # 전체 프로세스 실행
        final_result = system.run_recommendation_process()
        
        if final_result:
            print("\n" + "=" * 60)
            print("🎉 최종 결과:")
            print("=" * 60)
            print(json.dumps(final_result, ensure_ascii=False, indent=2))
            print("\n✅ 모든 프로세스가 성공적으로 완료되었습니다!")
        else:
            print("❌ 추천 프로세스 실패")
            
    except Exception as e:
        print(f"❌ 테스트 실행 오류: {e}")
        import traceback
        traceback.print_exc()

def test_individual_components():
    """개별 컴포넌트 테스트"""
    print("\n=== 개별 컴포넌트 테스트 ===")
    
    try:
        system = LangChainTodoRecommendationSystem()
        
        # 1. 파일 로딩 테스트
        print("\n1. 파일 로딩 테스트")
        combined_data = system.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_data.json')
        p_data = combined_data['p_data']  # 과거 완료된 할일 데이터
        h_data = combined_data['h_data']  # 오늘 예정된 할일 데이터
        
        if p_data and h_data:
            print("✅ 더미 데이터 로딩 성공")
            print(f"   - P데이터: {len(p_data)}일치")
            print(f"   - H데이터: {len(h_data.get('scheduled_todos', {}))}개 카테고리")
        else:
            print("❌ 더미 데이터 로딩 실패")
            return
        
        # 2. 프롬프트 템플릿 테스트
        print("\n2. 프롬프트 템플릿 테스트")
        p_data_str = json.dumps(p_data, ensure_ascii=False, indent=2)
        h_data_str = json.dumps(h_data, ensure_ascii=False, indent=2)
        
        first_prompt = system.first_prompt_template.format(
            p_data=p_data_str[:200] + "...",
            h_data=h_data_str[:200] + "...",
            format_instructions=system.json_parser.get_format_instructions()
        )
        print("✅ 첫 번째 프롬프트 템플릿 생성 성공")
        print(f"   - 프롬프트 길이: {len(first_prompt)} 문자")
        
        # 3. JSON 파서 테스트
        print("\n3. JSON 파서 테스트")
        test_json = '{"test": "success"}'
        test_with_text = f'여기 결과입니다: {test_json} 이상입니다.'
        
        try:
            parsed = system.json_parser.parse(test_with_text)
            print("✅ JSON 파서 테스트 성공")
            print(f"   - 파싱된 결과: {parsed}")
        except Exception as e:
            print(f"❌ JSON 파서 테스트 실패: {e}")
        
        print("\n✅ 모든 컴포넌트 테스트 완료")
        
    except Exception as e:
        print(f"❌ 컴포넌트 테스트 오류: {e}")
        import traceback
        traceback.print_exc()

def main():
    """메인 테스트 함수"""
    print("LangChain 기반 Todo 추천 시스템 테스트")
    print("=" * 60)
    
    # 개별 컴포넌트 테스트 먼저 실행
    test_individual_components()
    
    print("\n" + "=" * 60)
    
    # 전체 시스템 테스트
    run_langchain_test()
    
    print("\n" + "=" * 60)
    print("🏁 모든 테스트 완료")

if __name__ == "__main__":
    main()