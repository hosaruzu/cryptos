//
//  HomeViewModel.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []

    init() {
        Task {
            try await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
            allCoins.append(Coin.mock)
            portfolioCoins.append(Coin.mock)
        }
    }

}
