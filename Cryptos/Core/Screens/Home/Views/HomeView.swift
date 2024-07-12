//
//  HomeView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct HomeView: View {

    // MARK: - View model
    @StateObject private var viewModel = HomeViewModel()

    // MARK: - State

    @State private var showPortfolio: Bool = false

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HomeHeader(isChanged: $showPortfolio)

                if viewModel.allCoins.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    listHeaderView
                    if !showPortfolio {
                        ListView(coins: viewModel.allCoins)
                            .transition(.move(edge: .leading))
                    } else {
                        ListView(coins: viewModel.portfolioCoins, showHolidngsColumn: true)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
        }
    }
}

extension HomeView {
    private var listHeaderView: some View {
        HStack {
            Text("Coin")
            Spacer()
            Text(showPortfolio ? "Holdings" : "")
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HomeView()
    }
}
