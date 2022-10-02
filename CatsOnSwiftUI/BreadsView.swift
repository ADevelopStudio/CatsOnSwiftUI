//
//  ContentView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

struct BreadsView: View {
    @StateObject private var viewModel = BreadsViewModel()
    
    
    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .idle:
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.breeds) { breed in
                            NavigationLink {
                                BreedDelailsView(breed: breed)
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
                .navigationTitle("Breeds")
            case .failed(let error):
                ErrorView(error: error)
            case .loading:
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .task {
            await viewModel.startFetching()
        }
    }
}

struct BreadsView_Previews: PreviewProvider {
    static var previews: some View {
        BreadsView()
    }
}
