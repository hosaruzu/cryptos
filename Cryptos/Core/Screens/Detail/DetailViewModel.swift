//
//  DetailViewModel.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {

    // MARK: - Properties

    @Published var errorMessage: String = ""

    let coin: Coin
    @Published var additionalCoinData: CoinAdditional?
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []

    @Published var isLoading: Bool = true

    // MARK: - Dependencies

    private let coinService: FetchCoinDetailService

    // MARK: - Init

    init(coin: Coin, coinService: FetchCoinDetailService = FetchCoinDetailService()) {
        self.coin = coin
        self.coinService = coinService
    }

    // MARK: - Public

    func onLoad() async {
        isLoading = true
        await fetchAdditionalCoinData()
        setupOverviewStatistics()
        setupDetailStatistics()
        isLoading = false
    }

    // MARK: - Fetch detail coin data

    private func fetchAdditionalCoinData() async {
        do {
            let additionalCoinData = try await coinService.fetchCoinAdditionalCoinData(id: coin.id)
            self.additionalCoinData = additionalCoinData
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Setup statistics info

    private func setupOverviewStatistics() {
        let price = coin.currentPrice.asCurrencyWith6Decimals
        let priceChange = coin.priceChangePercentage24H

        let marketCap = "$\(coin.marketCap.formattedWithAbbreviations)"
        let marketCapChange = coin.marketCapChangePercentage24H

        let rank = "\(coin.marketCapRank)"

        let volume = "$\(coin.totalVolume.formattedWithAbbreviations)"

        overviewStatistics = [
            Statistic(type: .detailRank, value: rank),
            Statistic(type: .detailCurrentPrice, value: price, percentageChange: priceChange),
            Statistic(type: .detailMarketCap, value: marketCap, percentageChange: marketCapChange),
            Statistic(type: .detailVolume, value: volume)
        ]
    }

    private func setupDetailStatistics() {
        let high = coin.high24H?.asCurrencyWith6Decimals ?? "n/a"

        let low = coin.low24H?.asCurrencyWith6Decimals ?? "n/a"

        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals ?? "n/a"
        let pricePercentChange = coin.priceChangePercentage24H

        let marketCapChange = "$\(coin.marketCapChange24H.formattedWithAbbreviations)"
        let marketCapPercentChange = coin.marketCapChangePercentage24H

        let blockTime = additionalCoinData?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"

        let hashingAlgorithm = additionalCoinData?.hashingAlgorithm ?? "n/a"

        additionalStatistics = [
            Statistic(type: .detail24HHigh, value: high),
            Statistic(type: .detail24HLow, value: low),
            Statistic(type: .detailPriceChange24H, value: priceChange, percentageChange: pricePercentChange),
            Statistic(type: .detailMarketCapChange, value: marketCapChange, percentageChange: marketCapPercentChange),
            Statistic(type: .detailBlockTime, value: blockTimeString),
            Statistic(type: .detailHashingAlgoritm, value: hashingAlgorithm)
        ]
    }
}
