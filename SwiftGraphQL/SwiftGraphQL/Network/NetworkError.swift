//
//  NetworkError.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

/// NetworkError, that defines the different types of errors that can occur during network calls
enum NetworkError: Error {
    case serverError
    case unauthorized
    case customError(String)
}

extension NetworkError: LocalizedError {
    
    /// This property is used to show error description to user
    var errorDescription: String? {
        switch self {
        case .serverError: return "Server Error"
        case .unauthorized: return "User unauthorized"
        case .customError(let errorString): return errorString
        }
    }
}
