//
//  SettingsView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 25.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss)
    private var dissmiss

    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            List {
                Section("Project info") {
                    HStack {
                        Image(.coingecko)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        if let coinGecko = viewModel.coinGeckoURL {
                            Link("CoinGecko API website", destination: coinGecko)
                        }
                    }
                    .padding(4)

                    HStack {
                        Image(.github)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        if let githubURL = viewModel.githubURL {
                            Link("App repository", destination: githubURL)
                        }
                    }
                    .padding(4)
                }
                Section("Contacts") {
                    HStack {
                        Image(systemName: "paperplane.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.blue)
                        if let telegramURL = viewModel.telegramURL {
                            Link("Message me in Telegram", destination: telegramURL)
                        }
                    }
                    .padding(4)

                    HStack {
                        Image(systemName: "envelope.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.blue)
                        if let mailURL = viewModel.mailURL {
                            Link("Mail me", destination: mailURL)
                        }
                    }
                    .padding(4)
                }
                .tint(Color.theme.primaryText)
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                .onDisappear {
                    UIScrollView.appearance().bounces = true
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dissmiss()
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                                .font(.title3)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}
