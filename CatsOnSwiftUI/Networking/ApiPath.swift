//
//  ApiPath.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation


enum ApiPath {
    case getAllBreads
//    case update(id: Int)
}


extension ApiPath {
    private static let apiKey = "live_MDKOxeU1Of6bDC5dkkj4j8wITpsMsNNgLbDVDvEhl5XbBbXg8C4wSNOWLg8yGFW0"
    
    private var path: String {
        switch self {
        case .getAllBreads:
            return "/breeds"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getAllBreads:
            return []
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com"
        components.path = ["/v1", self.path].joined()
        let queryAppId = URLQueryItem(name: "api_key", value: ApiPath.apiKey)
        components.queryItems = self.queryItems + [queryAppId]
        return components.url
    }
}


