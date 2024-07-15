//
//  Statistic.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 15.07.2024.
//

import Foundation

struct Statistic: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?

    init(
        title: String,
        value: String,
        percentageChange: Double? = nil
    ) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

extension Statistic {
    static let mock = [
        Statistic(title: "Market Cap", value: "$12.5Bn", percentageChange: -0.5),
        Statistic(title: "Total volume", value: "$1.23Tr"),
        Statistic(title: "Another volume", value: "$13Tr", percentageChange: 1),
        Statistic(title: "Third data", value: "$2", percentageChange: nil)
        ]
}
