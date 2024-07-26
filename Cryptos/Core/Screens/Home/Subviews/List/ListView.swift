//
//  ListView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import SwiftUI

struct ListView<Content: View>: View {

    @EnvironmentObject var viewModel: HomeViewModel

    private let coins: [Coin]
    private let showHolidngsColumn: Bool
    private let footer: Content

    @Binding var showDetailScreen: Bool

    init(
        coins: [Coin],
        showDetailScreen: Binding<Bool>,
        showHolidngsColumn: Bool = false,
        @ViewBuilder footer: () -> Content
    ) {
        self.coins = coins
        self._showDetailScreen = showDetailScreen
        self.showHolidngsColumn = showHolidngsColumn
        self.footer = footer()
    }

    init(
        coins: [Coin],
        showDetailScreen: Binding<Bool>,
        showHolidngsColumn: Bool = false
    ) where Content == EmptyView {
        self.init(
            coins: coins,
            showDetailScreen: showDetailScreen,
            showHolidngsColumn: showHolidngsColumn
        ) {
            EmptyView()
        }
    }

    var body: some View {
        List {
            ForEach(coins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showHolidngsColumn)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedCoin = coin
                        showDetailScreen.toggle()
                    }
            }
            footer
                .listRowSeparator(.hidden, edges: .bottom)
        }
        .listStyle(.plain)
    }

}

#Preview {
    ListView(
        coins: [Coin.mock],
        showDetailScreen: .constant(true),
        showHolidngsColumn: true) {
        Text("Footer")
    }
}
