//
//  HomeViewModel.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Puplic properties

    /// Coins: initial list & filtered list
    @Published var allCoins: [Coin] = []
    @Published var filterCoins: [Coin] = []

    /// Coins for portfolio list
    @Published var portfolioCoins: [Coin] = []

    /// Statistics data
    @Published var statistics: [Statistic] = []

    /// Current loading state
    @Published var isLoading = true

    /// Error message
    @Published var errorMessage: String = ""

    /// Searching
    @Published var searchText: String = "" {
        didSet {
            inSearchMode = !searchText.isEmpty
            performLocalSearch()
        }
    }
    @Published var inSearchMode = false {
        didSet {
            reloadPortfolio(with: inSearchMode ? filterCoins : allCoins)
        }
    }

    @Published var selectedCoin: Coin?

    // MARK: - Pagination
    /// Current page
    private(set) var page: Int = 1
    /// Pagination state
    @Published var hasMoreCoins = true

    // MARK: - Dependecies

    private let coinService = FetchCoinsService()
    private let marketDataService = FetchMarketDataService()
    private let portfolioDataService = PortfolioDataService()

    // MARK: - Coin service

    func onRefresh() async {
        allCoins = []
        filterCoins = []
        statistics = []
        do {
            await fetchMarketData()
            let coins = try await coinService.fetchCoins(page: 1)
            allCoins.append(contentsOf: coins)
            reloadPortfolio(with: allCoins)
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func onLoad() async {
        isLoading = true
        do {
            try await fetchCoins()
            await fetchMarketData()
            reloadPortfolio(with: allCoins)
            updatePortfolioStats()
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    private func fetchCoins() async throws {
        let coins = try await coinService.fetchCoins(page: page)
        allCoins.append(contentsOf: coins)
        hasMoreCoins = !coins.isEmpty
        page += 1
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

    // MARK: - Market data service

    private func fetchMarketData() async {
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
        return [marketCap, volume, btcDominance]
    }

    // MARK: - Portfolio data service

    private func reloadPortfolio(with coins: [Coin]) {
        let entities = portfolioDataService.getPortfolio()
        portfolioCoins = entities.compactMap { entity in
            if let coin = coins.first(where: { $0.id == entity.coinID }) {
                return coin.updateHoldings(amount: entity.amount)
            }
            return nil
        }
    }

    private func updatePortfolioStats() {
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)

        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

        let portfolio = Statistic(
            type: .portfolio,
            value: portfolioValue.asCurrencyWith2Decimals,
            percentageChange: percentageChange)

        if statistics.count > 3 {
            statistics.removeLast()
            statistics.append(portfolio)
        } else {
            statistics.append(portfolio)
        }
    }

    func updatePortfolio(_ coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin, amount: amount)
        reloadPortfolio(with: allCoins)
        updatePortfolioStats()
    }
}
