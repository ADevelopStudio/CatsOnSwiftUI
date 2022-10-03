//
//  CachedImage.swift
//  WeatherOnSwiftUI
//
//  Created by Dmitrii Zverev on 24/8/2022.
//

import Foundation
import SwiftUI

struct CachedImage: View {
    @StateObject private var manager = CachedImageManager()
    
    let urlString: String?
    let animation: Animation?
    let transition: AnyTransition
    
    init(url: String?,
         animation: Animation? = .spring(),
         transition: AnyTransition = .opacity) {
        self.urlString = url
        self.animation = animation
        self.transition = transition
    }
    
    
    var body: some View {
        ZStack {
            switch manager.currentState {
            case .loading:
                ProgressView()
                    .transition(transition)
            case .success(let data):
                if let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .transition(transition)
                } else {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .symbolRenderingMode(.multicolor)
                        .setIconStyle()
                        .transition(transition)
                }
            case .failed:
                Image(systemName: "eye.slash.circle.fill")
                    .symbolRenderingMode(.multicolor)
                    .setIconStyle()
                    .transition(transition)
            case .none:
                EmptyView()
            }
        }
        .animation(animation, value: manager.currentState)
        .task {
            await manager.load(urlString)
        }
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(url: "https://avatars.githubusercontent.com/u/5238454?v=4")
    }
}

extension CachedImage {
    enum CachedImageError: Error {
        case invalidData
    }
}
