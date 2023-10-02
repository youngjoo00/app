//
//  LoginModel.swift
//  Daeseda
//
//  Created by youngjoo on 2023/09/27.
//

import Foundation

struct LoginResponse: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: LoginData?
}
struct LoginData: Codable {
    let id: String
}
