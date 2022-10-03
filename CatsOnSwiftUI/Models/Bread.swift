//
//  Bread.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

struct Breed: Codable, Identifiable, BreedListCellDataModel {
    let id: String
    let name: String
    let altNames: String?
    let temperament: String
    let origin: String
    let countryCode: String
    let description: String
    let lifeSpan: String
    private let image: BreedImage?
    private let weight: BreedWeight
    
    //URLs
    let wikipediaUrl: String?
    let cfaUrl: String?
    let vetstreetUrl: String?
    let vcahospitalsUrl: String?
    
    //Levels (0-5)
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    
    //True/False (0=False, 1 = true)
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let suppressedTail: Int
    let shortLegs: Int
    let hypoallergenic: Int
}

extension Breed {
    var imageUrl: String? { image?.url }
    var weightDescr: String { "\(self.weight.metric)kg (\(self.weight.imperial)lb)" }
    
    var statData: [BreedStatData] {
        [
            BreedStatData(title: "adaptability", value: adaptability),
            BreedStatData(title: "affectionLevel", value: affectionLevel),
            BreedStatData(title: "childFriendly", value: childFriendly),
            BreedStatData(title: "dogFriendly", value: dogFriendly),
            BreedStatData(title: "energyLevel", value: energyLevel),
            BreedStatData(title: "grooming", value: grooming),
            BreedStatData(title: "healthIssues", value: healthIssues),
            BreedStatData(title: "intelligence", value: intelligence),
            BreedStatData(title: "sheddingLevel", value: sheddingLevel),
            BreedStatData(title: "socialNeeds", value: socialNeeds),
            BreedStatData(title: "strangerFriendly", value: strangerFriendly),
            BreedStatData(title: "vocalisation", value: vocalisation)
        ]
    }
    
    var links: [BreedStatLink] {
        [
            BreedStatLink(title: "Wikipedia", urlString: wikipediaUrl),
            BreedStatLink(title: "CFA.org", urlString: cfaUrl),
            BreedStatLink(title: "VetStreet.com", urlString: vetstreetUrl),
            BreedStatLink(title: "VCA Aminal Hospitals", urlString: vcahospitalsUrl)
        ].compactMap{$0}
    }
}


struct BreedWeight: Codable {
    let imperial: String
    let metric: String
}

struct BreedImage: Codable, Identifiable {
    let id: String
    let url: String
}

struct BreedStatData: BreedStatDataModel, Hashable {
    var title: String
    var value: Int
}

struct BreedStatLink: Hashable {
    var title: String
    var url: URL
    
    init?(title: String, urlString: String?) {
        guard let urlString, let url = URL(string: urlString) else { return nil }
        self.title = title
        self.url = url
    }
}
