//
//  RequestProtocol.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var queryParams: [String: String?] { get }
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }

    var requestType: RequestType {
        .get
    }

    func request() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path

        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = components.url else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.name
        return urlRequest
    }
}

enum RequestType: String {
    case get

    var name: String {
        self.rawValue.uppercased()
    }
}
