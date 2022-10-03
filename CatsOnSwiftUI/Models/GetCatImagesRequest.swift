//
//  SearchParameters.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

struct GetCatImagesRequest: Encodable {
    static let pageLimit: Int = 25

    
    ///The size of image to return - small, med or full. small is perfect for Discord. Defaults to med
    var size: String? = "med"
    
    ///Comma delimited string of the image types to return gif, jpg, orpng. Defaults to return all types jpg
    var mimeTypes: String? = "jpg"
    
    ///Response format json, orsrc. src will redirect straight to the image, so is useful for putting a link straight into HTML as the 'src' on an 'img' tag. Defaults to json
    var format: String? = "json"
    
    ///The order to return results in. RANDOM, ASC or DESC. If either ASC or DESC is passed then the Pagination headers will be on the response allowing you to see the total amount of results, and your current page. Default is RANDOM
    var order: String? = "RANDOM"
    
    ///Integer - used for Paginating through all the results. Only used when order is ASC or DESC
    var page: Int?
    
    ///Integer - number of results to return. Without an API Key you can only pass 1, with a Key you can pass up to 25. Default is 1
    var limit: Int? = 1
    
    ///Comma delimited string of integers, matching the id's of the Categories to filter the search. These categories can found in the /v1/categories request. e.g. category_ids=2
    var categoryIds: String? = nil
    
    ///Comma delimited string of integers, matching the id's of the Breeds to filter the search. These categories can found in the /v1/breeds request
    var breedId: String? = nil
    
//    ///For ther  Greed
//    init(page: Int, breedId: String) {
//        self.page = page
//        self.breedId = breedId
//        self.limit = Self.pageLimit
//        self.order = "ASC"
//    }
//
//    static func forGreed(page: Int, breedId: String) -> GetCatImagesRequest {
//        GetCatImagesRequest(order: "ASC", page: page, limit: Self.pageLimit, breedId: breedId)
//    }
//    
//    static func forSample(breedId: String) -> GetCatImagesRequest {
//        GetCatImagesRequest(limit:5, breedId: breedId)
//    }
}
