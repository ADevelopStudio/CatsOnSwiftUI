//
//  BreedListCell.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

protocol BreedListCellDataModel {
    var imageUrl: String? { get }
    var name: String { get }
}

struct BreedListCell: View {
    private var element: BreedListCellDataModel
    
    var body: some View {
        ZStack {
            Group {
                CachedImage(url: element.imageUrl, transition: .opacity.combined(with: .scale(scale: 0.6)))
                LinearGradient(colors: [.clear, .black.opacity(0.6)],
                               startPoint: .center,
                               endPoint: .bottom)
            }
            .frame(height: 240)
            .clipped()
            .padding(.horizontal, -20)
            .padding(.vertical, -10)
        }
        .overlay(alignment: .bottomLeading) {
            Text(element.name)
                .font(.title)
                .foregroundColor(.white)
                .padding(.vertical, 4)
                .padding(.horizontal)
        }
    }
    
    init(_ element: BreedListCellDataModel) {
        self.element = element
    }
}

struct BreedListCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BreedListCell(Breed.example)
        }
    }
}
