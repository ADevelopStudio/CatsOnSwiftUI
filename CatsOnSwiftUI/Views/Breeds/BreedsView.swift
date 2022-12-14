//
//  ContentView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

struct BreedsView<T>: View where T: BreedsViewModel {
    @ObservedObject private var viewModel:T
    
    init(viewModel: T = BreedsViewModelImpl()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .idle:
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.breeds) { breed in
                            NavigationLink {
                                BreedDelailsView(viewModel: BreedDelailsViewModelImpl(breed: breed))
                            } label: {
                                BreedListCell(breed)
                            }
                        }
                        if !viewModel.isBreedListFull{
                            ProgressView()
                                .padding()
                                .onAppear {
                                    Task { await viewModel.loadNextPage() }
                                }
                        }
                    }
                }
                .navigationTitle(BreedsViewStrings.title.localised)
            case .failed(let error):
                ErrorView(error: error)
            case .loading:
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .animation(.easeInOut, value: viewModel.loadingState)
        .task {
            await viewModel.startFetching()
        }
    }
}

struct BreedsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsView()
    }
}

enum BreedsViewStrings: String, CaseIterable {
    case title = "BreedsView_Title" //"Cat Breeds"
}
