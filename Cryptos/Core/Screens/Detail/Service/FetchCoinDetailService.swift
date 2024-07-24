//
//  FetchCoinDetailService.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import Foundation

final class FetchCoinDetailService {

    // MARK: - Dependencies

    private let requestManager: RequestManagerProtocol

    // MARK: - Init

    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }

    // MARK: - Fetch coins

    func fetchCoin(id: String) async throws -> CoinDetail {
        let requestData = DetailCoinRequest.getCoin(id: id)
        let coin: CoinDetail = try await requestManager.request(with: requestData)
        return coin
    }
}
