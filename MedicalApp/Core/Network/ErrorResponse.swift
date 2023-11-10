//
//  ErrorResponse.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import Foundation

enum ErrorHandling: Error {
    case generalError
    case parsingError
}

struct ErrorResponse: Codable {
    var errorCode: String?
    var error: String?
    
    public static func genericError() -> ErrorResponse {
        return ErrorResponse(errorCode: "401", error: "General error!")
    }
}
