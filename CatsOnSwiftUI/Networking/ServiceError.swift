//
//  ServiceError.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case generalFailure
    case invalidStatus
    case invalidUrl
    
    var errorDescription: String? {
        switch self {
        case .invalidStatus:
            return "Nothing found"
        case .generalFailure:
            return "Something went wrong"
        case .invalidUrl:
            return "Invalid Url"
        }
    }
}
