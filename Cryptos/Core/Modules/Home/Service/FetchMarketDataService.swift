//
//  FetchMarketDataService.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 22.07.2024.
//

import Foundation

final class FetchMarketDataService {
    // MARK: - Dependencies

    private let requestManager: RequestManagerProtocol

    // MARK: - Init

    init(requestManager: some RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }

    // MARK: - Fetch coins

    func fetchMarketData() async throws -> MarketData {
        let requestData = MarketDataRequest.getMarketData
        let marketData: MarketDataResponse = try await requestManager.request(with: requestData)
        return marketData.data
    }
}
