//
//  SettingsViewModel.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 25.07.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var coinGeckoURL = URL(string: "https://www.coingecko.com")
    @Published var githubURL = URL(string: "https://github.com/hosaruzu/cryptos")
    @Published var telegramURL = URL(string: "https://t.me/aatebenkov")
    @Published var mailURL = URL(string: "mailto:artem.tebenkov@icloud.com")
}
