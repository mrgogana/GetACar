//
//  NetworkError.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation

// MARK: - Network Error
enum NetworkError: Error {
    
    case fileNotFound
    case dataError(String?)

    func errorMsg() -> String {
        switch self {
        case .fileNotFound:
            return "Invalid Data. Please Try Later."
        case .dataError(let description):
            return description ?? "An unexpected error occurred. Please Try Later."
        }
    }
}
