//
//  MarketDataRequest.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 22.07.2024.
//

import Foundation

enum MarketDataRequest: RequestProtocol {

    case getMarketData

    var path: String {
        "/api/v3/global"
    }

    var queryParams: [String: String?] {
        [:]
    }
}
