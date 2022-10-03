//
//  ErrorView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import SwiftUI

struct ErrorView: View {
    var error: Error

    var body: some View {
        VStack {
            Image(systemName: "xmark.icloud")
                .setIconStyle()
            Text(error.localizedDescription)
                .font(.title)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: ServiceError.generalFailure)
    }
}
