//
//  CloseModalButtonView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 4/10/2022.
//

import SwiftUI

struct CloseModalButtonView: View {
    var body: some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.secondary)
            .padding()
    }
}

struct CloseModalButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CloseModalButtonView()
    }
}
