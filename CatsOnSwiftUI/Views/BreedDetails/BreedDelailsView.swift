//
//  BreedDelailsView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

struct BreedDelailsView: View {
    @ObservedObject var viewModel: BreedDelailsViewModel

    init(breed: Breed) {
        self.viewModel = BreedDelailsViewModel(breed: breed)
    }
        
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    if let imageUrl = viewModel.breed.imageUrl, !imageUrl.isEmpty {
                        CachedImage(url: viewModel.breed.imageUrl)
                    } else {
                        Color.clear
                            .frame(height: 160)
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    CountryView(countryCode: viewModel.breed.countryCode, countryName: viewModel.breed.origin)
                        .padding()
                }
                
                Group {
                    Text(viewModel.breed.name)
                        .font(.title)
                    if let anotherNames = viewModel.breed.altNames,
                       !anotherNames.isEmpty {
                        Text("(\(anotherNames))")
                            .font(.title2)
                    }
                    
                    Text(viewModel.breed.description)
                        .font(.body)
                    switch viewModel.loadingState {
                    case .failed:
                        EmptyView()
                    case .idle:
                        if viewModel.images.isEmpty {
                            EmptyView()
                        } else {
                            Text("\(BreedDelailsViewStrings.sectionPhotos.localised):")
                                .asSectionHeader()
                            CarouselView(breed: viewModel.breed, images: viewModel.images)
                        }
                    case .loading:
                        ProgressView()
                    }
                    
                    Text("\(BreedDelailsViewStrings.sectionStat.localised):")
                        .asSectionHeader()
                    ForEach(viewModel.breed.statData, id: \.self) {
                        BreedStatView(dataModel: $0)
                    }
                    
                    if !viewModel.breed.links.isEmpty {
                        Text("\(BreedDelailsViewStrings.sectionLinks.localised):")
                            .asSectionHeader()
                    }
                    ForEach(viewModel.breed.links, id: \.self) {
                        Link($0.title, destination: $0.url)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                Spacer()
            }
        }
        .animation(.easeInOut, value: viewModel.loadingState)
        .ignoresSafeArea(edges: .top)
        .task {
            await viewModel.fetchImages()
        }
    }
}

struct BreedDelailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDelailsView(breed: .example)
    }
}


enum BreedDelailsViewStrings: String, CaseIterable {
    case sectionPhotos = "BreedDelailsView_photos" //"Photos"
    case sectionStat = "BreedDelailsView_stat" //"Stat"
    case sectionLinks = "BreedDelailsView_links" //"Links"
}
