//
//  UserApiService.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import Foundation

class UserApiServices {
    private let networkService: NetworkService = NetworkService.instance
    
    func login(email: String, password: String, completion: @escaping (_ isSuccess: Bool, _ token: String) -> Void) {
        let serviceTarget = UserApiRouter.login(email: email, password: password)
        networkService.request(target: serviceTarget, model: LoginResponse.self) { (result) in
            switch result {
                case .success(let response):
                    debugPrint("#Success: \(response.token ?? .emptyString)")
                    completion(true, response.token ?? .emptyString)
                case .failure(let error):
                    debugPrint("#Error: \(error.localizedDescription)")
                    completion(false, error.localizedDescription)
            }
        }
    }
}
