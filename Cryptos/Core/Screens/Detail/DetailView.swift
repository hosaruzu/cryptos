//
//  DetailView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import SwiftUI

struct DetailView: View {

    let coin: Coin

    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: Coin.mock)
}
