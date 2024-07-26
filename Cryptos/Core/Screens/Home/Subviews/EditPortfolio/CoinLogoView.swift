//
//  CoinLogoView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 22.07.2024.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: Coin

    var body: some View {
        VStack {
            ImageView(urlString: coin.image, width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.primaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: Coin.mock)
}
