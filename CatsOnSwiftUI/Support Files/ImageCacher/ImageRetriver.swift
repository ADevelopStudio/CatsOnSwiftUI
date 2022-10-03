//
//  ImageRetriver.swift
//  WeatherOnSwiftUI
//
//  Created by Dmitrii Zverev on 24/8/2022.
//

import Foundation

struct ImageRetriver {
    func fetch(_ imgUrl: URL) async throws -> Data {
        var urlRequest =  URLRequest(url: imgUrl)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return data
    }
}
