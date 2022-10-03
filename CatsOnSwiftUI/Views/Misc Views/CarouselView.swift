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
    @State private var isShowingFullGallery: Bool = false

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
                
                GeometryReader { proxy in
                    let scale = self.getScale(proxy: proxy)
                        VStack(spacing: 20) {
                            Text("🐈")
                                .font(.largeTitle)
                            Text("\(CarouselViewStrings.morePhotos.localised) \(Image(systemName: "chevron.right"))")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                        }
                        .asCarouselCard(cardSize: cardSize, scale: scale)
                        .onTapGesture {
                            isShowingFullGallery = true
                        }
                }
                .frame(width: cardSize.width + 20, height: cardSize.height + 30)
            }
            .padding(32)
        }
        .fullScreenCover(item: $selectedBreedImage) { _ in
            FullScreenImageView(selectedBreedImage: $selectedBreedImage)
        }
        .fullScreenCover(isPresented: $isShowingFullGallery) {
            GalleryView(isShowingModal: $isShowingFullGallery, viewModel: GalleryViewModelImpl(breed: self.breed))
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

enum CarouselViewStrings: String, CaseIterable {
    case morePhotos = "CarouselView_more_photos" //"More photos"
}
