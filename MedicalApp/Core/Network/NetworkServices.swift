//
//  NetworkServices.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import Foundation
import Moya

protocol NetworkServiceProtocol: AnyObject {
    func request<T: TargetType, M: Decodable>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void)
}

class Provider: NetworkServiceProtocol {
    
    private var provider: MoyaProvider<MultiTarget>?
    private var isDebug: Bool
    
    init(isDebugMode: Bool = false) {
        isDebug = isDebugMode
        if isDebug {
            provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin()])
        } else {
            provider = MoyaProvider<MultiTarget>()
        }
    }
    
    public func request<T, M>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void) where T : TargetType, M : Decodable {
        self.provider?.request(MultiTarget(target)) { [self] (result) in
            switch result {
            case .success(let response):
                do {
                    if self.isDebug {
                        let jsonObject = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                        debugPrint(jsonObject)
                    }
                    if response.statusCode == 400 {
                        let errorResponse = try response.map(ErrorResponse.self)
                        let errorData = NSError(domain: errorResponse.error ?? .emptyString, code: response.statusCode, userInfo: nil)
                        completion(.failure(errorData))
                    } else {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let result = try filteredResponse.map(model)
                        completion(.success(result))
                    }
                } catch(let error) {
                    debugPrint(error)
                    completion(.failure(ErrorHandling.parsingError))
                }
            case .failure(let error):
                print(error.errorCode)
                print(error.response)
                print(error.errorUserInfo)
                print(error.errorDescription)
                print(error.localizedDescription)
                debugPrint(error)
                completion(.failure(ErrorHandling.generalError))
            }
        }
    }
}

class NetworkService {
    static var instance = NetworkService()
    private var delegate: NetworkServiceProtocol?
    
    init(networkServiceProtocol: NetworkServiceProtocol = Provider()) {
        self.delegate = networkServiceProtocol
    }
    
    public func request<T: TargetType, M: Decodable>(target: T, model modelType: M.Type, completion: @escaping (Result<M, Error>) -> Void ){
        self.delegate?.request(target: target, model: modelType, completion: completion)
    }
}
