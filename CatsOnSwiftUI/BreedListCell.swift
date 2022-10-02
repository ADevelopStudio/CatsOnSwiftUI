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
                CachedImage(url: element.imageUrl)
                LinearGradient(colors: [.clear, .black.opacity(0.6)],
                               startPoint: .center,
                               endPoint: .bottom)
            }
            .frame(height: 200)
            .clipped()
            .padding(.horizontal, -20)
            .padding(.vertical, -10)
            
            VStack {
                Spacer()
                Text(element.name)
                    .font(.title)
                    .foregroundColor(.white)
                
            }
            .padding(4)
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
