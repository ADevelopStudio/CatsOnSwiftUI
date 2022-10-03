//
//  BreedsViewModel.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

protocol BreedsViewModel: AnyObject, ObservableObject{
    var breeds: [Breed] { get }
    var loadingState: LoadingState { get }
    var isBreedListFull: Bool { get }
    func loadNextPage() async
    func startFetching() async
    init(service: NetworkService)
}

    
class BreedsViewModelImpl: BreedsViewModel{
    @Published private(set) var loadingState: LoadingState = .idle
    @Published private(set) var breeds: [Breed] = []
    @Published private(set) var isBreedListFull: Bool = false
    
    private var currentlyLoadedPage = 0
    private var isLoadingNewPage: Bool = false
    private let service: NetworkService
    
    required init(service: NetworkService = ConnectionManager.shared) {
        self.service = service
    }
    
    @MainActor
    func startFetching() async {
        self.loadingState = .loading
        isLoadingNewPage = true
        do {
            let result = try await service.fetchBreeds(parameters: GetBreedsRequest(page: 1))
            self.currentlyLoadedPage = 1
            isBreedListFull = result.count < GetBreedsRequest.pageLimit
            self.loadingState = .idle
            self.breeds = result
            isLoadingNewPage = false
        } catch {
            isLoadingNewPage = false
            self.loadingState = .failed(error)
        }
    }
    
    @MainActor
    func loadNextPage() async {
        if isLoadingNewPage { return }
        do {
            isLoadingNewPage = true
            currentlyLoadedPage += 1
            let result = try await service.fetchBreeds(parameters: GetBreedsRequest(page: currentlyLoadedPage))
            isBreedListFull = result.count < GetBreedsRequest.pageLimit
            self.breeds = self.breeds + result
            isLoadingNewPage = false
        } catch {
            isBreedListFull = true
            isLoadingNewPage = false
        }
    }
}
