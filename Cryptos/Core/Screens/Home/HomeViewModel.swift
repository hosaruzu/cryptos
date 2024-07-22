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

    @Published var statistics: [Statistic] = Statistic.mock
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

    private let coinService = FetchCoinsService()
    private let marketDataService = FetchMarketDataService()

    init() {
        isLoading = true
    }

    func fetchCoins() async {
        isLoading = true
        do {
            await fetchMarketData()
            let coins = try await coinService.fetchCoins(page: page)
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

    func fetchMarketData() async {
        do {
            let marketData = try await marketDataService.fetchMarketData()
            statistics = createStatistics(with: marketData)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func createStatistics(with data: MarketData) -> [Statistic] {
        let marketCap = Statistic(
            type: .marketCap,
            value: data.marketCap,
            percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(
            type: .volume,
            value: data.volume)
        let btcDominance = Statistic(
            type: .dominance,
            value: data.btcDominance)
        let portfolio = Statistic(
            type: .portfolio,
            value: "$0.0",
            percentageChange: 1)
        return [marketCap, volume, btcDominance, portfolio]
    }

    func saveToPortfolio(_ coin: Coin, holdings: Double) {
        let coin = coin.updateHoldings(amount: holdings)
        portfolioCoins.append(coin)
    }
}
