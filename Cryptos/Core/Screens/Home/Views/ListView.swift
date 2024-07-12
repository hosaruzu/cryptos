//
//  ListView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import SwiftUI

struct ListView: View {

    private let coins: [Coin]
    private let showHolidngsColumn: Bool

    init(coins: [Coin], showHolidngsColumn: Bool = false) {
        self.coins = coins
        self.showHolidngsColumn = showHolidngsColumn
    }

    var body: some View {
        List {
            ForEach(coins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showHolidngsColumn)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
}
