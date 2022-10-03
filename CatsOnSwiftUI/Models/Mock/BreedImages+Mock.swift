//
//  BreedImages+Mock.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import Foundation
extension BreedImage {
    static var examples: [BreedImage] {
        let str = #"""
[{
    "id": "d8sbdRtLJ",
    "url": "https://cdn2.thecatapi.com/images/d8sbdRtLJ.jpg",
    "width": 1050,
    "height": 1126
}, {
    "id": "5hmYjVhib",
    "url": "https://cdn2.thecatapi.com/images/5hmYjVhib.jpg",
    "width": 935,
    "height": 1000
}, {
    "id": "oLtx9gsxx",
    "url": "https://cdn2.thecatapi.com/images/oLtx9gsxx.jpg",
    "width": 4027,
    "height": 2680
}, {
    "id": "uvyjW5KIG",
    "url": "https://cdn2.thecatapi.com/images/uvyjW5KIG.jpg",
    "width": 3008,
    "height": 2000
}, {
    "id": "pK_t-KYIi",
    "url": "https://cdn2.thecatapi.com/images/pK_t-KYIi.jpg",
    "width": 637,
    "height": 421
}]
"""#
        guard let data = str.data(using: .utf8) else { fatalError("String can not be coverted to data") }
        do {
            let obj = try Utilites.decoder.decode([BreedImage].self, from: data)
            return obj
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
