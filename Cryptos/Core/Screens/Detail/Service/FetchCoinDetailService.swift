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

    func fetchCoinAdditionalCoinData(id: String) async throws -> CoinAdditional {
        let requestData = DetailCoinRequest.getCoin(id: id)
        let coin: CoinAdditional = try await requestManager.request(with: requestData)
        return coin
    }
}
