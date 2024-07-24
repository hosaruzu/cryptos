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
    @Binding var showDetailScreen: Bool
    @Binding var selectedCoin: Coin

    init(
        coins: [Coin],
        showDetailScreen: Binding<Bool>,
        selectedCoin: Binding<Coin>,
        showHolidngsColumn: Bool = false,
        @ViewBuilder footer: () -> Content
    ) {
        self.coins = coins
        self._showDetailScreen = showDetailScreen
        self._selectedCoin = selectedCoin
        self.showHolidngsColumn = showHolidngsColumn
        self.footer = footer()
    }

    init(
        coins: [Coin],
        showDetailScreen: Binding<Bool>,
        selectedCoin: Binding<Coin>,
        showHolidngsColumn: Bool = false
    ) where Content == EmptyView {
        self.init(
            coins: coins,
            showDetailScreen: showDetailScreen,
            selectedCoin: selectedCoin,
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
                        selectedCoin = coin
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
        selectedCoin: .constant(Coin.mock),
        showHolidngsColumn: true) {
        Text("Footer")
    }
}
