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
            .foregroundColor(.red)
            .frame(width: size, height: size)
    }
}

extension Image {
    func setIconStyle(size: CGFloat = 80) -> some View {
        self.resizable()
            .modifier(IconImage(size: size))
    }
}


/*

 */
