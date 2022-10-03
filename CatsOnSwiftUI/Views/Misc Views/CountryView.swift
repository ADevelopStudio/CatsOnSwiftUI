//
//  CountryView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 3/10/2022.
//

import SwiftUI
struct CountryView: View {
    var countryCode: String
    var countryName: String
    
    var body: some View {
        HStack {
            Text(Utilites.getFlag(from: countryCode))
            Text(countryName)
        }
        .padding(6)
        .background(Color.primary.colorInvert().opacity(0.7))
        .cornerRadius(8)
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(countryCode: "EG", countryName: "Egypt")
    }
}
