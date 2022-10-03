//
//  BreedDelailsViewModel.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import Foundation

@MainActor
class BreedDelailsViewModel: ObservableObject {
    @Published private(set) var loadingState: LoadingState = .loading
    @Published private(set) var images: [BreedImage] = []
    
    private(set) var breed: Breed
    private let service: NetworkService
    
    init(breed: Breed, service: NetworkService = ConnectionManager.shared) {
        self.breed = breed
        self.service = service
    }
    
    func fetchImages() async {
        self.loadingState = .loading
        do {
            let result = try await service.fetchImages(parameters: GetCatImagesRequest(limit:5, breedId: breed.id))
            self.images = result
            self.loadingState = .idle
        } catch {
            self.loadingState = .failed(error)
        }
    }
}
