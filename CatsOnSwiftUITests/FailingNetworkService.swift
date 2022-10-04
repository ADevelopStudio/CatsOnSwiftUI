//
//  FailingNetworkService.swift
//  CatsOnSwiftUITests
//
//  Created by Dmitrii Zverev on 4/10/2022.
//

import Foundation
@testable import CatsOnSwiftUI

class FailingConnectionManager {
    private(set) var error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    fileprivate func fetch<T: Decodable>(apiPath: ApiPath) async throws -> T {
        throw error
    }
}


extension FailingConnectionManager: NetworkService {
    func fetchBreeds(parameters: GetBreedsRequest) async throws -> [Breed] {
        try await self.fetch(apiPath: .getAllBreeds(parameters))
    }
    func fetchImages(parameters: GetCatImagesRequest) async throws -> [BreedImage] {
        try await self.fetch(apiPath: .getAllCatImages(parameters))
    }
}
