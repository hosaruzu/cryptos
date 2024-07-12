//
//  CoinRequest.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

enum CoinRequest: RequestProtocol {
    case getCoins(page: Int = 1)

    var path: String {
        "/api/v3/coins/markets"
    }

    var queryParams: [String : String?] {

        switch self {
        case .getCoins(let page):
            var params = [
                "vs_currency": "usd",
                "per_page": "20",
                "page": "\(page)",
                "sparkline": "\(true)",
                "price_change_percentage": "24h"
            ]
            return params
        }
    }
}
