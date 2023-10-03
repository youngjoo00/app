//
//  APICollection.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/19.
//

import Foundation

struct APICollection {
    static let baseURL = "http://localhost:8088"
    
    // "http://localhost:8088/users/signup"
    static let loginURL = baseURL + "/users/authenticate"
    
    // "http://localhost:8088/users/signup"
    static let signUpURL = baseURL + "/users/signup"
    
    
//    static let postURL = "http://localhost:8888/users/register"

}
