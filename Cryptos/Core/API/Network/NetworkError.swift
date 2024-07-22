//
//  NetworkError.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 12.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse(Int)
}
