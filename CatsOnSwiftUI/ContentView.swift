//
//  ContentView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    private let service = ConnectionManager()

    func startFetching() async {
        print(Breed.example.name)
        do {
            let result = try await service.fetchBreeds()
            print("Success:\(result.count)")
        } catch {
            print("Error:")
            print(error)
        }
    }
}


struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()


    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await viewModel.startFetching()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
