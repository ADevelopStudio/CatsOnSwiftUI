//
//  ConnectionManager.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

protocol NetworkService {
    func fetchBreeds(parameters: GetBreedsRequest) async throws -> [Breed]
    func fetchImages(parameters: GetCatImagesRequest) async throws -> [BreedImage]
}


class ConnectionManager {
    static let shared = ConnectionManager()
    
    private func fetch<T: Decodable>(url: URL?) async throws -> T {
        guard let url else { throw ServiceError.invalidUrl }
        var urlRequest =  URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try Utilites.decoder.decode(T.self, from: data)
    }
    
    fileprivate func fetch<T: Decodable>(apiPath: ApiPath) async throws -> T {
        try await self.fetch(url: apiPath.url)
    }
}


extension ConnectionManager: NetworkService {
    func fetchBreeds(parameters: GetBreedsRequest) async throws -> [Breed] {
        try await self.fetch(apiPath: .getAllBreads(parameters))
    }
    func fetchImages(parameters: GetCatImagesRequest) async throws -> [BreedImage] {
        try await self.fetch(apiPath: .getAllCatImages(parameters))
    }
}
