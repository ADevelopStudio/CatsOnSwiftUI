//
//  LoadingState.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import Foundation

enum LoadingState {
    case loading
    case failed(Error)
    case idle
}

extension LoadingState: Equatable {
    private var descr: String {
        String(describing: self)
    }

    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool { rhs.descr == lhs.descr }
}
