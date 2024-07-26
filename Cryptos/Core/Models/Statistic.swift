//
//  Statistic.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 15.07.2024.
//

import Foundation

enum StatisticsType: String {
    // Home
    case marketCap = "Market Cap"
    case volume = "24H Volume"
    case dominance = "BTC Dominance"
    case portfolio = "Portfolio value"

    // Details
    case detailCurrentPrice = "Current price"
    case detailMarketCap = "Market Capitalization"
    case detailRank = "Rank"
    case detailVolume = "Total volume"
    case detail24HHigh = "24h High"
    case detail24HLow = "24h Low"
    case detailPriceChange24H = "24h Price change"
    case detailMarketCapChange = "24h Market cap change"
    case detailBlockTime = "Block time"
    case detailHashingAlgoritm = "Hashing algoritm"
}

struct Statistic: Identifiable {
    let id = UUID().uuidString
    private let type: StatisticsType
    let value: String
    let percentageChange: Double?

    init(
        type: StatisticsType,
        value: String,
        percentageChange: Double? = nil
    ) {
        self.type = type
        self.value = value
        self.percentageChange = percentageChange
    }
}

extension Statistic {
    var title: String {
        type.rawValue
    }

    static let mock = [
        Statistic(type: .marketCap, value: "$12.5Bn", percentageChange: -0.5),
        Statistic(type: .volume, value: "$1.23Tr"),
        Statistic(type: .dominance, value: "$13Tr", percentageChange: 1),
        Statistic(type: .portfolio, value: "$2", percentageChange: nil)
    ]
}
