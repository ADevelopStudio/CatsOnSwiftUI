//
//  Extensions.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 4/10/2022.
//

import Foundation

extension Encodable {
    var toDictionary: [String: AnyHashable] {
        (try? JSONSerialization.jsonObject(with: Utilites.encoder.encode(self)) as? [String: AnyHashable]) ?? [:]
    }
    
    var toQueryItems: [URLQueryItem] {
        toDictionary.map{URLQueryItem(name: $0.key, value: String(describing: $0.value))}
    }
}

extension String {
    var localised: String { NSLocalizedString(self, comment: self) }
}

extension RawRepresentable where RawValue == String {
    var localised: String { self.rawValue.localised }
}

