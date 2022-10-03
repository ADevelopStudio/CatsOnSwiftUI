//
//  GalleryViewModel.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import Foundation

protocol GalleryViewModel: AnyObject, ObservableObject{
    var breed: Breed { get }
    var images: [BreedImage] { get }
    var loadingState: LoadingState { get }
    var isBreedListFull: Bool { get }
    func loadNextPage() async
    func fetchImages() async
    init(breed: Breed, service: NetworkService)
}

class GalleryViewModelImpl: GalleryViewModel{
    private(set) var breed: Breed
    
    @Published private(set) var loadingState: LoadingState = .loading
    @Published private(set) var images: [BreedImage] = []
    
    @Published private(set) var isBreedListFull: Bool = false
    private var currentlyLoadedPage = 0
    private var isLoadingNewPage: Bool = false
    private let service: NetworkService
    
    required init(breed: Breed, service: NetworkService = ConnectionManager.shared) {
        self.breed = breed
        self.service = service
    }
    
    @MainActor
    func fetchImages() async {
        self.loadingState = .loading
        isLoadingNewPage = true
        do {
            currentlyLoadedPage = 1
            let result = try await service.fetchImages(parameters: self.generateNextPageRequest())
            images = result
            loadingState = .idle
            isLoadingNewPage = false
            isBreedListFull = result.count < GetCatImagesRequest.pageLimit
        } catch {
            loadingState = .failed(error)
            isLoadingNewPage = false
            isBreedListFull = true
        }
    }
    
    @MainActor
    func loadNextPage() async {
        if isLoadingNewPage || isBreedListFull { return }
        do {
            isLoadingNewPage = true
            currentlyLoadedPage += 1
            let result = try await service.fetchImages(parameters: self.generateNextPageRequest())
            isBreedListFull = result.count < GetCatImagesRequest.pageLimit
            self.images = self.images + result
            isLoadingNewPage = false
        } catch {
            isBreedListFull = true
            isLoadingNewPage = false
        }
    }
    
    private func generateNextPageRequest() -> GetCatImagesRequest {
        //SOMEHOW order ASC or DESC gives an empty response so decided to use RANDOM to get at least something
        GetCatImagesRequest(order: "RANDOM",
                            page: currentlyLoadedPage,
                            limit: GetCatImagesRequest.pageLimit,
                            breedId: breed.id)
    }
}
