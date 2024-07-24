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
    @Published var isLoading: Bool = true

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
        }
    }

    func fetchCoins() async {
        isLoading = true
        do {
            await fetchMarketData()
            let coins = try await coinService.fetchCoins(page: page)
            allCoins.append(contentsOf: coins)
            reloadPortfolio(with: allCoins)
            hasMoreCoins = !coins.isEmpty
            page += 1
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
        isLoading = false
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

    // MARK: - Portfolio data service

    func reloadPortfolio(with coins: [Coin]) {
        let entities = portfolioDataService.getPortfolio()
        portfolioCoins = entities.compactMap { entity in
            if let coin = coins.first(where: { $0.id == entity.coinID }) {
                return coin.updateHoldings(amount: entity.amount)
            }
            return nil
        }
    }

    func updatePortfolio(_ coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin, amount: amount)
        reloadPortfolio(with: allCoins)
    }
}
