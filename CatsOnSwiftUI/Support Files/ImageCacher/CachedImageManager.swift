//
//  CachedImageManager.swift
//  WeatherOnSwiftUI
//
//  Created by Dmitrii Zverev on 24/8/2022.
//

import Foundation

final class CachedImageManager: ObservableObject {
    
    @Published private(set) var currentState: CurrentState?
    
    private let imageRetriver = ImageRetriver()
    
    @MainActor
    func load(_ imgStringUrl: String?, cache: ImageCache = .shared) async {
        guard let imgStringUrl, let imgUrl = URL(string: imgStringUrl) else {
            self.currentState = .failed(error: ServiceError.invalidUrl)
            return
        }
        
        if let imageData = cache.object(forkey: imgStringUrl as NSString) {
            print("imgStringUrl ALREADY")
            self.currentState = .success(data: imageData)
            return
        }
        print("imgStringUrl LOADING")
        self.currentState = .loading
        do {
            let data = try await imageRetriver.fetch(imgUrl)
            cache.set(object: data as NSData, forKey: imgStringUrl as NSString)
            self.currentState = .success(data: data)
        } catch {
            self.currentState = .failed(error: error)
        }
    }
}

extension CachedImageManager {
    enum CurrentState {
        case loading
        case failed(error: Error)
        case success(data: Data)
    }
}

extension CachedImageManager.CurrentState: Equatable {
    static func == (lhs: CachedImageManager.CurrentState, rhs: CachedImageManager.CurrentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (let .failed(lhsError), let .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (let .success(lhsData), let .success(rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}
