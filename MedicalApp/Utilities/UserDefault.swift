//
//  UserDefault.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import Foundation

class UserDefault {
    private static let tokenKey = "UserToken"
    
    static func saveUserToken(token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    static func getUserToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static func removeUserToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
