//
//  ConnectionManager.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

final class ConnectionManager {
    fileprivate func fetch<T: Decodable>(url: URL?) async throws -> T {
        guard let url else { throw ServiceError.invalidUrl }
        print(url.absoluteString)
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        if let str = String(data: data, encoding: .utf8) {
            print(str)
        }
        return try Utilites.decoder.decode(T.self, from: data)
    }
}


extension ConnectionManager {
    func fetchBreeds() async throws -> [Breed] {
        return try await self.fetch(url: ApiPath.getAllBreads.url)
    }
}
