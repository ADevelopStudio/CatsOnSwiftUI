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
            return ServiceErrorStrings.invalidStatus.localised
        case .generalFailure:
            return ServiceErrorStrings.generalFailure.localised
        case .invalidUrl:
            return ServiceErrorStrings.invalidUrl.localised
        }
    }
}


enum ServiceErrorStrings: String, CaseIterable {
    case invalidStatus = "ServiceError_invalid_status" //"Nothing found"
    case generalFailure = "ServiceError_general_failure" //"Something went wrong"
    case invalidUrl = "ServiceError_invalid_url" //"Invalid Url"
}
