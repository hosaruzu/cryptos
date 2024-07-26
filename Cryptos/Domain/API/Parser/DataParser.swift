//
//  DataParser.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(type: T.Type, data: Data) throws -> T
}

final class DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func parse<T: Decodable>(type: T.Type, data: Data) throws -> T {
        return try jsonDecoder.decode(type, from: data)
    }
}
