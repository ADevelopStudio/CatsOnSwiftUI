//
//  WaterfallView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import SwiftUI

struct GalleryView: View {
    @ObservedObject var viewModel: GalleryViewModel
    @State private var selectedBreedImage: BreedImage?
    
    init(breed: Breed) {
        self.viewModel = GalleryViewModel(breed: breed)
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
                            LazyVGrid(columns: [GridItem(.flexible())]) {
                                ForEach(viewModel.images) { img in
                                    CachedImage(url: img.url)
                                        .frame(minHeight: 100)
                                        .onTapGesture {
                                            self.selectedBreedImage = img
                                        }
                                }
                                if !viewModel.isBreedListFull{
                                    ProgressView()
                                        .padding()
                                        .frame(minHeight: 100)
                                        .onAppear {
                                            Task { await viewModel.loadNextPage() }
                                        }
                                }
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
    }
}

struct OneColunGreedView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(breed: .example)
    }
}
