#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
from todo_recommendation_system import TodoRecommendationSystem

def run_full_test_with_real_api():
    """실제 API를 사용한 전체 테스트"""
    print("\n=== 실제 API 테스트 ===")
    
    # .env에서 API 키를 읽어오므로 직접 입력받지 않음
    try:
        system = TodoRecommendationSystem()
        
        # 실제 데이터 로딩
        p_data = system.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_p_data.json')
        h_data = system.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_h_data.json')
        
        if not p_data or not h_data:
            print("❌ 더미 데이터 로딩 실패")
            return
        
        print("더미 데이터 로딩 완료")
        
        # 첫 번째 GPT 호출
        print("첫 번째 GPT 호출 중...")
        first_response = system.call_gpt_first_recommendation(p_data, h_data)
        if not first_response:
            print("❌ 첫 번째 GPT 호출 실패")
            return
        
        print(f"첫 번째 GPT 응답 (일부): {first_response[:150]}...")
        
        # 첫 번째 필터링
        first_filtered = system.filter_json_response(first_response)
        if not first_filtered or 'recommendations' not in first_filtered:
            print("❌ 첫 번째 필터링 실패")
            return
        
        print(f"✅ 첫 번째 추천 {len(first_filtered['recommendations'])}개 추출")

        # 여기에 추가!
        system.save_json_file(first_filtered, 'first_recommendations.json')
        print("첫 번째 추천 결과를 first_recommendations.json에 저장했습니다.")
        
        # 두 번째 GPT 호출
        print("두 번째 GPT 호출 중...")
        second_response = system.call_gpt_final_recommendation(p_data, h_data, first_filtered['recommendations'])
        if not second_response:
            print("❌ 두 번째 GPT 호출 실패")
            return
        
        print(f"두 번째 GPT 응답 (일부): {second_response[:150]}...")
        
        # 두 번째 필터링
        second_filtered = system.filter_json_response(second_response)
        if not second_filtered or 'final_recommendations' not in second_filtered:
            print("❌ 두 번째 필터링 실패")
            return
        
        print(f"✅ 최종 추천 {len(second_filtered['final_recommendations'])}개 추출")
        
        # 최종 출력 생성
        final_output = system.generate_final_output(second_filtered['final_recommendations'])
        
        print("\n최종 결과:")
        print(json.dumps(final_output, ensure_ascii=False, indent=2))
        
        # 파일 저장
        system.save_json_file(final_output, 'final_recommendations.json')
        
    except Exception as e:
        print(f"❌ API 테스트 오류: {e}")

def main():
    """메인 테스트 함수"""
    print("Todo 추천 시스템 테스트 시작")
    print("=" * 50)
    
    run_full_test_with_real_api()
    
    print("\n" + "=" * 50)
    print("모든 테스트 완료")

if __name__ == "__main__":
    main()