//
//  Modifiers.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

private struct IconImage: ViewModifier {
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.secondary)
            .frame(width: size, height: size)
    }
}

extension Image {
    func setIconStyle(size: CGFloat = 80) -> some View {
        resizable()
            .modifier(IconImage(size: size))
    }
}


private struct CustomSectionHeader: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            Divider()
            HStack {
                content
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary.opacity(0.6))
                Spacer()
            }
        }
    }
}

extension Text {
    func asSectionHeader() -> some View {
        modifier(CustomSectionHeader())
    }
}


private struct CarouselCardView: ViewModifier {
    var cardSize: CGSize
    var scale: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemBackground).shadow(.drop(radius: 5, x: 2, y: 4)))
            content
                .frame(width: cardSize.width, height: cardSize.height)
                    .clipped()
                    .cornerRadius(10)
        }
        .shadow(radius: 2)
            .frame(width: cardSize.width, height: cardSize.height)
            .scaleEffect(CGSize(width: scale, height: scale))
    }
}

extension View {
    func asCarouselCard(cardSize: CGSize, scale: CGFloat) -> some View {
        modifier(CarouselCardView(cardSize: cardSize, scale: scale))
    }
}
