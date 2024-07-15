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

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func request(with data: some RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: data.request())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw NetworkError.invalidServerResponse }
        return data
    }
}
