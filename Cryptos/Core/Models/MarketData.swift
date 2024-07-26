//
//  MarketData.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 22.07.2024.
//

import Foundation

struct MarketDataResponse: Decodable {
    let data: MarketData
}

struct MarketData: Decodable {
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
}

extension MarketData {
    var marketCap: String {
        "$" + getValueBy(key: "usd", in: totalMarketCap).formattedWithAbbreviations
    }

    var volume: String {
        "$" + getValueBy(key: "usd", in: totalVolume).formattedWithAbbreviations
    }

    var btcDominance: String {
        getValueBy(key: "btc", in: marketCapPercentage).asTruncatedPercentString
    }

    private func getValueBy(key: String, in dict: [String: Double]) -> Double {
        if let item = dict.first(where: { $0.key == key }) {
            return item.value
        }
        return 0.0
    }
}
