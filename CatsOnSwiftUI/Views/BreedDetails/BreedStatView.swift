//
//  BreedStatView.swift
//  CatsOnSwiftUI
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import SwiftUI

protocol BreedStatDataModel {
    var title: String { get }
    var value: Int { get } /// From 0 to 5
}

struct BreedStatView: View {
    var dataModel: BreedStatDataModel
    
    var body: some View {
        HStack {
            Text(dataModel.title)
                .font(.callout)
                .bold()
            Spacer()
            HStack(spacing: 2) {
                ForEach(0 ..< 5) { index in
                    Rectangle()
                        .foregroundColor(index < dataModel.value ? .accentColor : .gray.opacity(0.3))
                        .frame(width: 30)
                }
            }
            .frame(maxHeight: 10)
            .clipShape(Capsule())
        }
    }
}

struct BreedStatView_Previews: PreviewProvider {
    static var previews: some View {
        BreedStatView(dataModel: TestBreedStatDataModel())
    }
}

private struct TestBreedStatDataModel : BreedStatDataModel {
    var title: String = "Some Value"
    var value: Int = 3
}
