//
//  UserApiRouter.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import Foundation
import Moya

enum UserApiRouter {
    case login(email: String, password: String)
}

extension UserApiRouter: TargetType {
    var baseURL: URL {
        return URL(string: "https://reqres.in/api")!
    }
    
    var path: String {
        switch self {
            case .login:
                return "/login"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
            case .login:
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    public var parameters: [String: Any] {
        switch self {
            case .login(let email, let password):
                return ["email": email,
                        "password": password]
        }
    }
    
    
    var headers: [String : String]? {
        return nil
    }
}
