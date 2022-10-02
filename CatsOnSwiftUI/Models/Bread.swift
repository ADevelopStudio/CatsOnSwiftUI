//
//  Bread.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

struct Breed: Codable {
    let id: String
    let name: String
    let altNames: String?
    let temperament: String
    let origin: String
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
}


struct BreedWeight: Codable {
    let imperial: String
    let metric: String
}

struct BreedImage: Codable {
    let id: String
    let url: String
}
