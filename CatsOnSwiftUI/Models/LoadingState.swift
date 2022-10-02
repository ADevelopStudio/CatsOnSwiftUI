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
