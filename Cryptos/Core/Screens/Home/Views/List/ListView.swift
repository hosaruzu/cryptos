//
//  ListView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import SwiftUI

struct ListView<Content: View>: View {

    private let coins: [Coin]
    private let showHolidngsColumn: Bool
    private let footer: Content

    init(
        coins: [Coin],
        showHolidngsColumn: Bool = false,
        @ViewBuilder footer: () -> Content
    ) {
        self.coins = coins
        self.showHolidngsColumn = showHolidngsColumn
        self.footer = footer()
    }

    init(
        coins: [Coin],
        showHolidngsColumn: Bool = false
    ) where Content == EmptyView {
        self.init(coins: coins, showHolidngsColumn: showHolidngsColumn) {
            EmptyView()
        }
    }

    var body: some View {
        List {
            ForEach(coins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showHolidngsColumn)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            footer
                .listRowSeparator(.hidden, edges: .bottom)
        }
        .listStyle(.plain)
    }

}

#Preview {
    ListView(coins: [Coin.mock], showHolidngsColumn: true) {
        Text("Footer")
    }
}
