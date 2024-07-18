//
//  CircleButtonView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct CircleButtonView: View {

    let iconName: String

    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 20, height: 20)
            .scaledToFit()
            .padding()
    }
}

#Preview() {
    Group {
        CircleButtonView(iconName: "info")
            .padding()

        CircleButtonView(iconName: "plus")
//            .preferredColorScheme(.dark)
            .padding()
    }
}
