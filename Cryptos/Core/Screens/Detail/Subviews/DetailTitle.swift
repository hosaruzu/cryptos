//
//  DetailTitle.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import SwiftUI

struct DetailTitle: View {

    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .foregroundStyle(Color.theme.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
        }
    }
}

#Preview {
    DetailTitle(title: "Title")
}
