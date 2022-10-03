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
    var weightDescr: String { "\(self.weight.metric)\(BreedStrings.weightMetric.localised)  (\(self.weight.imperial)\(BreedStrings.weightImperial.localised))" }
    
    var statData: [BreedStatData] {
        [
            BreedStatData(title: BreedStrings.adaptability.localised, value: adaptability),
            BreedStatData(title: BreedStrings.affectionLevel.localised, value: affectionLevel),
            BreedStatData(title: BreedStrings.childFriendly.localised, value: childFriendly),
            BreedStatData(title: BreedStrings.dogFriendly.localised, value: dogFriendly),
            BreedStatData(title: BreedStrings.energyLevel.localised, value: energyLevel),
            BreedStatData(title: BreedStrings.grooming.localised, value: grooming),
            BreedStatData(title: BreedStrings.healthIssues.localised, value: healthIssues),
            BreedStatData(title: BreedStrings.intelligence.localised, value: intelligence),
            BreedStatData(title: BreedStrings.sheddingLevel.localised, value: sheddingLevel),
            BreedStatData(title: BreedStrings.socialNeeds.localised, value: socialNeeds),
            BreedStatData(title: BreedStrings.strangerFriendly.localised, value: strangerFriendly),
            BreedStatData(title: BreedStrings.vocalisation.localised, value: vocalisation)
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

enum BreedStrings: String, CaseIterable {
    case adaptability = "BreedStrings_adaptability" //"adaptability"
    case affectionLevel = "BreedStrings_affection_level" //"affectionLevel"
    case childFriendly = "BreedStrings_child_friendly" //"childFriendly"
    case dogFriendly = "BreedStrings_dog_friendly" //"dogFriendly"
    case energyLevel = "BreedStrings_energy_level" //"energyLevel"
    case grooming = "BreedStrings_grooming" //"grooming"
    case healthIssues = "BreedStrings_health_issues" //"healthIssues"
    case intelligence = "BreedStrings_intelligence" //"intelligence"
    case sheddingLevel = "BreedStrings_shedding_level" //"sheddingLevel"
    case socialNeeds = "BreedStrings_social_needs" //"socialNeeds"
    case strangerFriendly = "BreedStrings_stranger_friendly" //"strangerFriendly"
    case vocalisation = "BreedStrings_vocalisation" //"vocalisation"
    case weightMetric = "BreedStrings_weight_metric" //"kg"
    case weightImperial = "BreedStrings_weight_imperial" //"lb"
}

