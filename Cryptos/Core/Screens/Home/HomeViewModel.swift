//
//  HomeViewModel.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var isLoading: Bool
    @Published var hasMoreCoins = true

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var errorMessage: String = ""
    @Published var searchText: String = ""

    private(set) var page: Int = 1

    private let service = FetchCoinsService()

    init() {
        isLoading = true
    }

    func fetchCoins() async {
        isLoading = true
        do {
            let coins = try await service.fetchCoins(page: page)
            allCoins.append(contentsOf: coins)
            hasMoreCoins = !coins.isEmpty
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func fetchMoreCoins() async {
        page += 1
        await fetchCoins()
    }

    private func search(with text: String) {

    }
}
