//
//  BreedDelailsView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

struct BreedDelailsView: View {
    var breed: Breed
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageUrl = breed.imageUrl, !imageUrl.isEmpty {
                    CachedImage(url: breed.imageUrl)
                }
                
                Group {
                    Text(breed.name)
                        .font(.title)
                    if let anotherNames = breed.altNames,
                       !anotherNames.isEmpty {
                        Text(anotherNames)
                            .font(.title2)
                    }
                    Text(breed.description)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)

                Spacer()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct BreedDelailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDelailsView(breed: .example)
    }
}
