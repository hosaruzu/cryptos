//
//  CoinDetail.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import Foundation

struct CoinDetail: Decodable {
    let id: String
    let symbol: String
    let name: String
    let blockTimeInMinutes: Int
    let hashingAlgorithm: String?
    let description: CoinDescription
    let links: Links
}

// MARK: - Description
// swiftlint:disable identifier_name
struct CoinDescription: Decodable {
    let en: String
}
// swiftlint:enable identifier_name

// MARK: - Links
struct Links: Decodable {
    let homepage: [String]
    let subredditURL: String?
}
