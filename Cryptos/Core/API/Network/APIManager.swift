//
//  APIManager.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

protocol APIManagerProtocol {
    func request(with data: some RequestProtocol) async throws -> Data
}

final class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    private let cacheService: NetworkCacheService

    init(
        urlSession: URLSession = .shared,
        cacheService: NetworkCacheService = NetworkCacheServiceImpl()
    ) {
        self.urlSession = urlSession
        self.cacheService = cacheService
    }

    func request(with data: some RequestProtocol) async throws -> Data {
        if let cachedData = cacheService.retrieveCachedData(for: try data.request()) {
            print("from cache")
            return cachedData
        }

        let (returnData, response) = try await urlSession.data(for: data.request())
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else { throw NetworkError.invalidServerResponse((response as? HTTPURLResponse)?.statusCode ?? 99) }
        cacheService.cacheData(
            from: try data.request(),
            cachedURLResponse: CachedURLResponse(response: response, data: returnData)
        )
        return returnData
    }
}
