//
//  HomeView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct HomeView: View {

    // MARK: - State

    @State private var showPortfolio: Bool = false

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HomeHeader(isChanged: $showPortfolio)
                Spacer(minLength: 0)
                List {
                    CoinRowView(coin: Coin.mock, showHoldingsColumn: true)
                }
                .listStyle(.inset)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HomeView()
    }
}
