//
//  WaterfallView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import SwiftUI

@MainActor
class OneColunGreedViewModel: ObservableObject {
    private(set) var breed: Breed
    
    @Published private(set) var loadingState: LoadingState = .loading
    @Published private(set) var images: [BreedImage] = []
    
    @Published private(set) var isBreedListFull: Bool = false
    private var currentlyLoadedPage = 0
    private var isLoadingNewPage: Bool = false
    
    private let service = ConnectionManager.shared
    
    init(breed: Breed) {
        self.breed = breed
    }
    
    
    func fetchImages() async {
        self.loadingState = .loading
        do {
            currentlyLoadedPage = 1
            let result = try await service.fetchImages(parameters: self.generateNextPageRequest())
//            let result = try await service.fetchImages(parameters: GetCatImagesRequest(limit: 10, breedId: breed.id))
            self.images = result
            self.loadingState = .idle
        } catch {
            self.loadingState = .failed(error)
        }
    }
    
    private func generateNextPageRequest() -> GetCatImagesRequest {
        GetCatImagesRequest(order: "RANDOM", page: currentlyLoadedPage, limit: GetCatImagesRequest.pageLimit, breedId: breed.id)
    }
}


struct OneColunGreedView: View {
    @ObservedObject var viewModel: OneColunGreedViewModel

    @State private var selectedBreedImage: BreedImage?

    init(breed: Breed) {
        self.viewModel = OneColunGreedViewModel(breed: breed)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                switch viewModel.loadingState {
                case .failed:
                    EmptyView()
                case .idle:
                    ScrollView {
                        VStack {
                            
                            //                        }
//                            Text(viewModel.breed.name)
                            //                        CarouselView(breed: viewModel.breed, images: viewModel.images)
                            LazyVGrid(columns: [GridItem(.flexible())]) {
                                ForEach(viewModel.images) { img in
                                    CachedImage(url: img.url)
                                        .frame(minHeight: 100)
                                        .onTapGesture {
                                            self.selectedBreedImage = img
                                        }
                                }
                                //                if !viewModel.isBreedListFull{
                                //                    ProgressView()
                                //                        .padding()
                                //                        .onAppear {
                                //                            Task { await viewModel.loadNextPage() }
                                //                        }
                                //                }
                            }
                        }
                    }
                    .fullScreenCover(item: $selectedBreedImage) { _ in
                        FullScreenImageView(selectedBreedImage: $selectedBreedImage)
                    }
                case .loading:
                    ProgressView()
                }
            }
        }
        .animation(.easeInOut, value: viewModel.loadingState)
        .task {
            await viewModel.fetchImages()
        }
        

//            .task {
//                await viewModel.fetchImages()
//            }
//            .padding(.vertical, 4)
//        }
    }
}

//struct OneColunGreedView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneColunGreedView(breed: .example)
//    }
//}
