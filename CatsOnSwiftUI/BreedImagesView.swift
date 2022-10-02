//
//  BreedImagesView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

struct BreedImagesView: View {
    var breedId: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BreedImagesView_Previews: PreviewProvider {
    static var previews: some View {
        BreedImagesView(breedId: Breed.example.id)
    }
}
