//
//  HomeHeader.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct HomeHeader: View {

    @Binding var isChanged: Bool

    var body: some View {
        HStack {
                CircleButtonView(iconName: isChanged ? "plus" : "info")
                    .animation(.none, value: isChanged)
                    .background(
                        CircleButtonAnimationView(animate: $isChanged)
                    )
                CircleButtonView(iconName: "arrow.clockwise")
            Spacer(minLength: 0)
            Text(isChanged ? "Portfolio" : "Prices")
                .animation(.none, value: isChanged)
                .font(.headline.bold())
                .foregroundStyle(Color.theme.accent)
            Spacer(minLength: 0)
            Spacer(minLength: 0)
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: isChanged ? UIConstants.rotationValue : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isChanged.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeHeader(isChanged: .constant(false))
}

private enum UIConstants {
    static let rotationValue: Double = 180
}
