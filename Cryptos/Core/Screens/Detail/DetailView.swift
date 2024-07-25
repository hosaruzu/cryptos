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

    @State private var showFullDescription: Bool = false

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
                            descriptionView
                        } else {
                            ProgressView()
                                .frame(height: 80)
                                .progressViewStyle(.circular)
                        }
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
                        linksView
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

    var descriptionView: some View {
        VStack {
            if let coinDescription =  viewModel.additionalCoinData?.readableDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                        .animation(.easeInOut, value: showFullDescription)
                    Button {
                        showFullDescription.toggle()
                    } label: {
                        Text(showFullDescription ? "Hide" : "Read more...")
                            .tint(.blue)
                            .font(.caption.bold())
                            .padding(.vertical, 4)
                            .animation(.easeInOut, value: showFullDescription)
                    }
                }

                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    var linksView: some View {
        VStack {
            if let website = viewModel.additionalCoinData?.links.homepage[0],
               let url = URL(string: website) {
                Link(destination: url) {
                    Text("\(viewModel.coin.name) website")
                }
            }
            if let website = viewModel.additionalCoinData?.links.subredditURL,
               let url = URL(string: website) {
                Link(destination: url) {
                    Text("Reddit \(viewModel.coin.name) page")
                }
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}

#Preview {
    NavigationView {
        DetailView(coin: Coin.mock)
    }
}
