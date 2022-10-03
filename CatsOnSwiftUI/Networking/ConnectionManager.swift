//
//  ConnectionManager.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

class ConnectionManager {
    static let shared = ConnectionManager()
    
    private func fetch<T: Decodable>(url: URL?) async throws -> T {
        guard let url else { throw ServiceError.invalidUrl }
        print(url.absoluteString)
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        if let str = String(data: data, encoding: .utf8) {
            print(str)
        }
        return try Utilites.decoder.decode(T.self, from: data)
    }
    
    fileprivate func fetch<T: Decodable>(apiPath: ApiPath) async throws -> T {
        try await self.fetch(url: apiPath.url)
    }
}


extension ConnectionManager {
    func fetchBreeds(parameters: GetBreedsRequest) async throws -> [Breed] {
        try await self.fetch(apiPath: .getAllBreads(parameters))
    }
    func fetchImages(parameters: GetCatImagesRequest) async throws -> [BreedImage] {
        try await self.fetch(apiPath: .getAllCatImages(parameters))
    }
}
