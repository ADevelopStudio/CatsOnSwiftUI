//
//  BreedDelailsViewModel.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import Foundation

protocol BreedDelailsViewModel: AnyObject, ObservableObject{
    var breed: Breed { get }
    var loadingState: LoadingState { get }
    var images: [BreedImage] { get }
    
    func fetchImages() async
    init(breed: Breed, service: NetworkService)
}

class BreedDelailsViewModelImpl: BreedDelailsViewModel {
    @Published private(set) var loadingState: LoadingState = .loading
    @Published private(set) var images: [BreedImage] = []
    
    private(set) var breed: Breed
    private let service: NetworkService
    
    required init(breed: Breed, service: NetworkService = ConnectionManager.shared) {
        self.breed = breed
        self.service = service
    }
    
    @MainActor
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
