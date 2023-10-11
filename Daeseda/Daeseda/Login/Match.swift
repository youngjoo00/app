//
//  Match.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/09.
//


import Foundation
import UIKit


func passwordMatch(_ password: String) -> String {
    var passwordErrorMessage = ""
    
    let regex1 = try! NSRegularExpression(pattern: "(?=.*[A-Z])")
    let regex2 = try! NSRegularExpression(pattern: "(?=.*[a-z])")
    let regex3 = try! NSRegularExpression(pattern: "(?=.*[0-9])")
    let regex4 = try! NSRegularExpression(pattern: "(?=.*[!@#$%^&*()_+=-])")
    let regex5 = try! NSRegularExpression(pattern: ".{8,50}")
    
    // 대문자 검사
    let uppercaseMatch = regex1.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
    // 소문자 검사
    let lowercaseMatch = regex2.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
    // 숫자 검사
    let digitMatch = regex3.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
    // 특수문자 검사
    let specialCharacterMatch = regex4.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
    // 길이 검사
    let lengthMatch = regex5.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
    
    switch (uppercaseMatch, lowercaseMatch, digitMatch, specialCharacterMatch, lengthMatch) {
    case (nil, nil, nil, nil, nil):
        passwordErrorMessage = "대문자, 소문자, 숫자, 특수문자를 포함해주세요.(8~50자)"
    
    case (nil, nil, nil, _, nil):
        passwordErrorMessage = "대문자, 소문자, 숫자를 포함해주세요.(8~50자)"
    case (nil, nil, nil, _, _):
        passwordErrorMessage = "대문자, 소문자, 숫자를 포함해주세요."
    case (nil, nil, _, nil, nil):
        passwordErrorMessage = "대문자, 소문자, 특수문자를 포함해주세요.(8~50자)"
    case (nil, nil, _, nil, _):
        passwordErrorMessage = "대문자, 소문자, 특수문자를 포함해주세요."
    case (nil, _, nil, nil, nil):
        passwordErrorMessage = "대문자, 숫자, 특수문자를 포함해주세요.(8~50자)"
    case (nil, _, nil, nil, _):
        passwordErrorMessage = "대문자, 숫자, 특수문자를 포함해주세요."
    case (_, nil, nil, nil, nil):
        passwordErrorMessage = "소문자, 숫자, 특수문자를 포함해주세요.(8~50자)"
    case (_, nil, nil, nil, _):
        passwordErrorMessage = "소문자, 숫자, 특수문자를 포함해주세요."
    
        
    case (nil, nil, _, _, nil):
        passwordErrorMessage = "대문자, 소문자를 포함해주세요.(8~50자)"
    case (nil, nil, _, _, _):
        passwordErrorMessage = "대문자, 소문자를 포함해주세요."
    case (nil, _, nil, _, nil):
        passwordErrorMessage = "대문자, 숫자를 포함해주세요.(8~50자)"
    case (nil, _, nil, _, _):
        passwordErrorMessage = "대문자, 숫자를 포함해주세요."
    case (nil, _, _, nil, nil):
        passwordErrorMessage = "대문자, 특수문자를 포함해주세요.(8~50자)"
    case (nil, _, _, nil, _):
        passwordErrorMessage = "대문자, 특수문자를 포함해주세요."
    case (_, nil, nil, _, nil):
        passwordErrorMessage = "소문자, 숫자를 포함해주세요.(8~50자)"
    case (_, nil, nil, _, _):
        passwordErrorMessage = "소문자, 숫자를 포함해주세요."
    case (_, nil, _, nil, nil):
        passwordErrorMessage = "소문자, 특수문자를 포함해주세요.(8~50자)"
    case (_, nil, _, nil, _):
        passwordErrorMessage = "소문자, 특수문자를 포함해주세요."
    case (_, _, nil, nil, nil):
        passwordErrorMessage = "숫자, 특수문자를 포함해주세요.(8~50자)"
    case (_, _, nil, nil, _):
        passwordErrorMessage = "숫자, 특수문자를 포함해주세요."
        
    
    case (nil, _, _, _, nil):
        passwordErrorMessage = "대문자를 포함해주세요.(8~50자)"
    case (nil, _, _, _, _):
        passwordErrorMessage = "대문자를 포함해주세요."
    case (_, nil, _, _, nil):
        passwordErrorMessage = "소문자를 포함해주세요.(8~50자)"
    case (_, nil, _, _, _):
        passwordErrorMessage = "소문자를 포함해주세요."
    case (_, _, nil, _, nil):
        passwordErrorMessage = "숫자를 포함해주세요.(8~50자)"
    case (_, _, nil, _, _):
        passwordErrorMessage = "숫자를 포함해주세요."
    case (_, _, _, nil, nil):
        passwordErrorMessage = "특수문자를 포함해주세요.(8~50자)"
    case (_, _, _, nil, _):
        passwordErrorMessage = "특수문자를 포함해주세요."
    case (_, _, _, _, nil):
        passwordErrorMessage = "8자 이상 작성해주세요."
    
    default:
        passwordErrorMessage = " "
    }
    
    return passwordErrorMessage
}


