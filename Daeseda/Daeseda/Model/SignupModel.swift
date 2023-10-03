//
//  signUpModel.swift
//  Daeseda
//
//  Created by youngjoo on 2023/09/27.
//

import Foundation

struct SignupResponse: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: SignupData?
}
struct SignupData: Codable {
    let id: String
}
