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
            .foregroundStyle(Color.theme.light)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.accent)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.5),
                radius: 10)
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "info")
            .padding()

        CircleButtonView(iconName: "plus")
            .preferredColorScheme(.dark)
            .padding()
    }
}
