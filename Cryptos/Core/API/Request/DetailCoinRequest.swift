//
//  DetailCoinRequest.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import Foundation

enum DetailCoinRequest: RequestProtocol {
    case getCoin(id: String)

    var path: String {
        switch self {
        case .getCoin(let id):
            "/api/v3/coins/\(id)"
        }
    }

    var queryParams: [String: String?] {
        switch self {
        case .getCoin:
            [
                "localization": "false",
                "tickers": "false",
                "market_data": "false",
                "community_data": "false",
                "sparkline": "false",
                "developer_data": "false"
            ]
        }
    }
}
