//
//  CoinRowView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 11.07.2024.
//

import SwiftUI

struct CoinRowView: View {

    let coin: Coin
    let showHoldingsColumn: Bool

    var body: some View {
            HStack(spacing: 0) {
                leadingColumn

                Spacer()

                if showHoldingsColumn {
                    centerColumn
                }

                trailingColumn
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            }
            .font(.subheadline)
    }
}

extension CoinRowView {
    private var leadingColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.marketCapRank)")
                .font(.caption)
                .foregroundStyle(Color.theme.primaryText)
                .frame(minWidth: 30)
            AsyncImage(url: URL(string: coin.image)) { result in
                if let image = result.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if result.error != nil {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.theme.secondaryText)
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.primaryText)
        }
    }

    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals)")
                .bold()

            Text(coin.currentHoldings?.asTruncatedNumberString ?? "0")
        }
        .foregroundStyle(Color.theme.primaryText)
    }

    private var trailingColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals)
                .bold()
                .foregroundStyle(Color.theme.primaryText)

            Text(coin.priceChangePercentage24H.asTruncatedPercentString)
                .foregroundStyle(
                    coin.priceChangePercentage24H > 0
                    ? Color.theme.green
                    : Color.theme.red
                )
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin: Coin.mock, showHoldingsColumn: true)
}
