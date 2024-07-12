//
//  RequestManager.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

protocol RequestManagerProtocol {
    var apiManager: APIManagerProtocol { get }
    var parser: DataParserProtocol { get }
    func request<T: Decodable>(with data: some RequestProtocol) async throws -> T
}

final class RequestManager: RequestManagerProtocol {
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol

    init(
        apiManager: APIManagerProtocol = APIManager(),
        parser: DataParserProtocol = DataParser()
    ) {
        self.apiManager = apiManager
        self.parser = parser
    }

    func request<T: Decodable>(with data: some RequestProtocol) async throws -> T {
        let data = try await apiManager.request(with: data)
        let decoded = try parser.parse(type: T.self, data: data)
        return decoded
    }
}
