//
//  CarouselView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import SwiftUI

struct CarouselView: View {
    private let cardSize = CGSize(width: Utilites.screenWidth/1.5, height:  Utilites.screenWidth/2)

    var breed: Breed
    var images: [BreedImage]
        
    @State private var selectedBreedImage: BreedImage?
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(images) { img in
                    GeometryReader { proxy in
                        let scale = self.getScale(proxy: proxy)
                        CachedImage(url: img.url)
                            .scaledToFill()
                            .asCarouselCard(cardSize: cardSize, scale: scale)
                            .onTapGesture {
                                selectedBreedImage = img
                            }
                    }
                    .frame(width: cardSize.width + 20, height: cardSize.height + 30)
                }
                if !images.isEmpty {
                    GeometryReader { proxy in
                        let scale = self.getScale(proxy: proxy)
                        NavigationLink {
                            GalleryView(breed: breed)
                        } label: {
                            VStack(spacing: 20) {
                                Text("🐈")
                                    .font(.largeTitle)
                                Text("More photos \(Image(systemName: "chevron.right"))")
                                    .font(.callout)
                            }
                            .asCarouselCard(cardSize: cardSize, scale: scale)
                        }
                    }
                    .frame(width: cardSize.width + 20, height: cardSize.height + 30)
                }
            }
            .padding(32)
        }
        .fullScreenCover(item: $selectedBreedImage) { _ in
            FullScreenImageView(selectedBreedImage: $selectedBreedImage)
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let diff = abs(proxy.frame(in: .global).minX)
        if diff < 100 {
            scale = 1 + (100 - diff) / 500
        }
        return scale
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CarouselView(breed: .example, images: BreedImage.examples)
        }
    }
}
