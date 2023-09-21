//
//  NetworkResult.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/19.
//

import Foundation

enum NetworkResult<T> {
    case success(T) // 서버 통신 성공
    case requestErr(T) // 요청 에러
    case pathErr // 경로 에러
    case serverErr // 서버 내부 에러
    case networkFail // 네트워크 연결 실패
}

struct Response: Codable {
    let success: Bool
    let result: String
    let message: String
}
