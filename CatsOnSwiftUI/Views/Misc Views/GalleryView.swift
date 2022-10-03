//
//  WaterfallView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import SwiftUI

struct GalleryView: View {
    @Binding var isShowingModal: Bool
    @ObservedObject var viewModel: GalleryViewModel
    @State private var selectedBreedImage: BreedImage?
    
    var body: some View {
        NavigationView {
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
                        .navigationTitle(viewModel.breed.name)
                        .fullScreenCover(item: $selectedBreedImage) { _ in
                            FullScreenImageView(selectedBreedImage: $selectedBreedImage)
                        }
                    case .loading:
                        ProgressView()
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.loadingState)
            .toolbar{
                Button {
                    isShowingModal.toggle()
                } label: {
                    CloseModalButtonView()
                }
            }
        }
        .task {
            await viewModel.fetchImages()
        }
    }
}

struct OneColunGreedView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(isShowingModal: .constant(false), viewModel: GalleryViewModel(breed: .example))
    }
}
