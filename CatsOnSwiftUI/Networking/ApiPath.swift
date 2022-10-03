//
//  ApiPath.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation


enum ApiPath {
    case getAllBreads(GetBreedsRequest)
    case getAllCatImages(GetCatImagesRequest)
//    case update(id: Int)
}


extension ApiPath {
    private static let apiKey = "live_MDKOxeU1Of6bDC5dkkj4j8wITpsMsNNgLbDVDvEhl5XbBbXg8C4wSNOWLg8yGFW0"
    
    private var path: String {
        switch self {
        case .getAllBreads:
            return "/breeds"
        case .getAllCatImages:
            return "/images/search"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getAllBreads(let request):
            return request.toQueryItems
        case .getAllCatImages(let request):
            return request.toQueryItems
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


