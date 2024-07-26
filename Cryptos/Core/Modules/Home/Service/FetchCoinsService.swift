//
//  FetchCoinsService.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

final class FetchCoinsService {
    // MARK: - Dependencies

    private let requestManager: RequestManagerProtocol

    // MARK: - Init

    init(requestManager: some RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }

    // MARK: - Fetch coins

    func fetchCoins(page: Int) async throws -> [Coin] {
        let requestData = CoinRequest.getCoins(page: page)
        let coins: [Coin] = try await requestManager.request(with: requestData)
        return coins
    }
}
