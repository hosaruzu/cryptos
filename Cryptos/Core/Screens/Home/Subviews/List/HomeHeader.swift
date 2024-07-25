//
//  HomeHeader.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct HomeHeader: View {

    @Binding var isChanged: Bool
    @Binding var showPortfolioView: Bool
    @Binding var showSettingsView: Bool

    var body: some View {
        HStack(spacing: 0) {
            CircleButtonView(iconName: isChanged ? "pencil" : "gearshape")
                .animation(.none, value: isChanged)
                .onTapGesture {
                    if isChanged {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $isChanged)
                )
            Spacer()
            Text(isChanged ? "Portfolio" : "Prices")
                .animation(.none, value: isChanged)
                .font(.headline.bold())
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: isChanged ? UIConstants.rotationValue : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isChanged.toggle()
                    }
                }
        }
    }
}

#Preview {
    HomeHeader(isChanged: .constant(true), showPortfolioView: .constant(true), showSettingsView: .constant(true))
}

private enum UIConstants {
    static let rotationValue: Double = 180
}
