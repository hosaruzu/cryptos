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
    @Published var filterCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var errorMessage: String = ""
    @Published var searchText: String = "" {
        didSet {
            inSearchMode = !searchText.isEmpty
            performLocalSearch()
        }
    }
    @Published var inSearchMode = false

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

    private func performLocalSearch() {
        guard !searchText.isEmpty else {
            filterCoins = allCoins
            return
        }
        filterCoins = allCoins.filter { coin in
            return coin.name.lowercased().contains(searchText.lowercased())
            || coin.symbol.lowercased().contains(searchText.lowercased())
            || coin.id.lowercased().contains(searchText.lowercased())
        }
    }
}
