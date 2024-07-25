//
//  DetailView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import SwiftUI

struct DetailView: View {

    @Environment(\.dismiss) private var dismiss

    // MARK: - View model

    @ObservedObject private var viewModel: DetailViewModel

    // MARK: - Init

    init(coin: Coin) {
        viewModel = DetailViewModel(coin: coin)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ChartView(coin: viewModel.coin)
                        .padding(.vertical)

                    VStack(spacing: 20) {
                        DetailTitle(title: "Overview")
                        if !viewModel.isLoading {
                            InfoVGrid(statistics: viewModel.overviewStatistics)
                        } else {
                            ProgressView()
                                .frame(height: 200)
                                .progressViewStyle(.circular)
                        }
                        DetailTitle(title: "Additional details")
                        if !viewModel.isLoading {
                            InfoVGrid(statistics: viewModel.additionalStatistics)
                        } else {
                            ProgressView()
                                .frame(height: 200)
                                .progressViewStyle(.circular)
                        }
                    }
                    .padding()
                }

            }
            .task {
                await viewModel.onLoad()
            }
            .navigationTitle(viewModel.coin.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    dismissButton
                }
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        subtitleView
                        ImageView(urlString: viewModel.coin.image)
                    }
                }
            }
        }
    }
}

private extension DetailView {
    var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }

    var subtitleView: some View {
        Text(viewModel.coin.symbol.uppercased())
            .font(.headline)
            .foregroundStyle(Color.theme.secondaryText)
    }
}

#Preview {
    NavigationView {
        DetailView(coin: Coin.mock)
    }
}
