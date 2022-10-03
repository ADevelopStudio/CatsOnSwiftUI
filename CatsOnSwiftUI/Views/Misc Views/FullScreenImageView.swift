//
//  FullScreenImageView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import SwiftUI

struct FullScreenImageView: View {
    @Binding var selectedBreedImage: BreedImage?
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var viewState = CGSize.zero
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in viewState = value.translation}
            .onEnded { _ in
                withAnimation {
                    viewState = .zero
                }
            }
        let pitchToZoom = MagnificationGesture()
            .onChanged { value in
                let delta = value / self.lastScaleValue
                self.lastScaleValue = value
                var newScale = self.scale * delta
                if newScale < 1.0 { newScale = 1.0 }
                scale = newScale
            }.onEnded{ _ in
                lastScaleValue = 1
            }
        let combined = dragGesture.exclusively(before: pitchToZoom)
        
        ZStack {
            Color(uiColor: UIColor.systemBackground)
            CachedImage(url: selectedBreedImage?.url)
                .scaledToFit()
                .scaleEffect(scale)
                .offset(x: viewState.width, y: viewState.height)
                .gesture(combined)
                .onTapGesture(count: 2) { // 3x on doubleTap
                    withAnimation {
                        scale = scale == 3 ? 1 : 3
                    }
                }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                selectedBreedImage = nil
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 30, weight: .light))
                    .foregroundColor(.accentColor)
                    .padding()
            }
        }
    }
}
