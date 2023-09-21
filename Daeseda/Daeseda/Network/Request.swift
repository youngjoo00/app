//
//  Request.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/19.
//

import Foundation
import Alamofire // HTTP 네트워킹 라이브러리

class Request{
    static let shared = Request() //싱글통 객체를 선언 -> 앱 어디에서든지 접근 가능
    private init(){}
    
    func requestGet(url: String, completionHandler: @escaping (Bool, Any) -> Void) {
        AF.request(url).responseJSON() { response in
            switch response.result {
            case .success:
                if let data = try! response.result.get() as? [String: Any] {
                    print(data)
                }
            case .failure(let error):
                print("Error: \(error)")
                return
            }
        }
    }
    
    func requestPost(url: String, param: [String: Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        //요청 : Request 생성
        //통신할 주소, HTTP메소드, 요청방식, 인코딩방식, 요청헤더
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: param,
                                     encoding: URLEncoding.httpBody,
                                     headers: ["Content-Type": "application/json"])
        
        //request 시작 ,responseData를 호출하면서 데이터 통신 시작
        dataRequest.responseData { response in
            switch response.result {
            case .success: // 성공
                guard let statusCode = response.response?.statusCode else { return }
                let networkResult = self.judgeStatus(by: statusCode)
                completion(networkResult)
            case .failure: // 실패
                completion(.networkFail)
            }
        }
    }
    
    // 상태 코드 범위 지정
    func judgeStatus(by statusCode: Int) -> NetworkResult<Any> {
        switch statusCode {
        case ..<300: return .success(true)
        case 400..<500: return .pathErr
        case 500..<600: return .serverErr
        default: return .networkFail
        }
    }
}
