//
//  ContentView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

@MainActor
class BreadsViewModel: ObservableObject {
    @Published private(set) var loadingState: LoadingState = .idle
    @Published private(set) var breeds: [Breed] = []

    private let service = ConnectionManager()

    func startFetching() async {
        self.loadingState = .loading
        do {
            let result = try await service.fetchBreeds()
            self.loadingState = .idle
            self.breeds = result
        } catch {
            print("Error:")
            print(error)
            self.loadingState = .failed(error)
        }
    }
}


struct BreadsView: View {
    @StateObject private var viewModel = BreadsViewModel()


    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .idle:
                BreedListView(breeds: viewModel.breeds)
            case .failed(let error):
                Text(error.localizedDescription)
            case .loading:
                ProgressView()
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
