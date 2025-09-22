#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
from todo_recommendation_system import TodoRecommendationSystem

def test_data_loading():
    """더미 데이터 로딩 테스트"""
    print("=== 데이터 로딩 테스트 ===")
    
    system = TodoRecommendationSystem()  # 임시 키
    
    # P데이터 테스트
    p_data = system.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_p_data.json')
    if p_data:
        print("✅ P데이터 로딩 성공")
        print(f"   - 총 {len(p_data)}일치 데이터")
        print(f"   - 첫째 날 완료 카테고리: {list(p_data[0]['completed_todos'].keys())}")
    else:
        print("❌ P데이터 로딩 실패")
    
    # H데이터 테스트
    h_data = system.load_json_file('/Users/woody/dotodo/dotodo_backend/models/recommendation/dummy_h_data.json')
    if h_data:
        print("✅ H데이터 로딩 성공")
        print(f"   - 오늘 날짜: {h_data['date']}")
        print(f"   - 예정 카테고리: {list(h_data['scheduled_todos'].keys())}")
        
        # 완료/미완료 상태 확인
        total_tasks = 0
        completed_tasks = 0
        for category, todos in h_data['scheduled_todos'].items():
            for todo in todos:
                total_tasks += 1
                if todo['completed']:
                    completed_tasks += 1
        print(f"   - 오늘 할일: {completed_tasks}/{total_tasks} 완료")
    else:
        print("❌ H데이터 로딩 실패")
    
    return p_data, h_data

def test_filtering_system():
    """필터링 시스템 테스트"""
    print("\n=== 필터링 시스템 테스트 ===")
    
    system = TodoRecommendationSystem()
    
    # 테스트 케이스들
    test_cases = [
        {
            "name": "정상 JSON",
            "response": '''여기 추천입니다: {"recommendations": [{"task": "테스트", "category": "공부", "reason": "테스트용"}]}'''
        },
        {
            "name": "텍스트 + JSON",
            "response": '''추천 결과입니다.
            
            {"recommendations": [{"task": "독서하기", "category": "자기계발", "reason": "지식 습득을 위해"}]}
            
            이상입니다.'''
        },
        {
            "name": "JSON 없음",
            "response": "죄송합니다. JSON을 제공할 수 없습니다."
        },
        {
            "name": "잘못된 JSON",
            "response": '''{"recommendations": [{"task": "테스트", "category": "공부"'''
        }
    ]
    
    for i, case in enumerate(test_cases, 1):
        print(f"\n테스트 {i}: {case['name']}")
        result = system.filter_json_response(case['response'])
        if result:
            print(f"✅ 필터링 성공: {len(result.get('recommendations', []))}개 항목")
        else:
            print("❌ 필터링 실패")

def test_output_generation():
    """출력 생성 테스트"""
    print("\n=== 출력 생성 테스트 ===")
    
    system = TodoRecommendationSystem()
    
    # 테스트용 최종 추천
    test_recommendations = [
        {"task": "책상 정리하기", "category": "집안일", "reason": "작업 환경 개선"},
        {"task": "자격증 공부하기", "category": "취업준비", "reason": "경쟁력 강화"},
        {"task": "스트레칭하기", "category": "운동", "reason": "건강 관리"}
    ]
    
    final_output = system.generate_final_output(test_recommendations)
    
    print("생성된 최종 출력:")
    print(json.dumps(final_output, ensure_ascii=False, indent=2))
    
    # 검증
    if (final_output.get('user_id') == 'user001' and 
        'date' in final_output and 
        len(final_output.get('recommendations', [])) == 3):
        print("✅ 출력 생성 성공")
    else:
        print("❌ 출력 생성 실패")

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
    
    # 1. 데이터 로딩 테스트
    p_data, h_data = test_data_loading()
    
    # 2. 필터링 시스템 테스트
    test_filtering_system()
    
    # 3. 출력 생성 테스트
    test_output_generation()
    
    # 4. 실제 API 테스트 (선택사항)
    run_full_test_with_real_api()
    
    print("\n" + "=" * 50)
    print("모든 테스트 완료")

if __name__ == "__main__":
    main()