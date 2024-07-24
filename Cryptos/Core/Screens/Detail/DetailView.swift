//
//  DetailView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import SwiftUI

struct DetailView: View {

    let coin: Coin
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text(coin.name)
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }

    }
}

#Preview {
    DetailView(coin: Coin.mock)
}
