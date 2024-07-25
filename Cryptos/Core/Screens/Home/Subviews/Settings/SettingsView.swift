//
//  SettingsView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 25.07.2024.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) private var dissmiss
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
                        Link("CoinGecko API website", destination: viewModel.coinGeckoURL!)
                    }
                    .padding(4)

                    HStack {
                        Image(.github)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Link("App repository", destination: viewModel.githubURL!)
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
                        Link("Message me in Telegram", destination: viewModel.telegramURL!)
                    }
                    .padding(4)

                    HStack {
                        Image(systemName: "envelope.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.blue)
                        Link("Mail me", destination: viewModel.mailURL!)
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
