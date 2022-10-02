//
//  BreedListView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

struct BreedListView: View {
    var breeds: [Breed]
    
    var body: some View {
        List(breeds) {
            BreedListCell($0)
        }
        .listStyle(.inset)
    }
}

struct BreedListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedListView(breeds: [.example, .example, .example])
    }
}
