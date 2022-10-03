//
//  GetBreedsRequest.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation


struct GetBreedsRequest: Encodable {
    static let pageLimit: Int = 20
    
    var page: Int
    let limit: Int = GetBreedsRequest.pageLimit
    
    init(page: Int) {
        self.page = page
    }
}
