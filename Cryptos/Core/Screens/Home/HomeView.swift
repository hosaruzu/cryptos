//
//  HomeView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct HomeView: View {

    // MARK: - View model
    @ObservedObject var viewModel: HomeViewModel

    // MARK: - State

    @State private var atPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var id = 0
    @State private var refreshID = UUID()

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    EditPortfolioView(viewModel: viewModel)
                        .onDisappear(perform: {
                            self.refreshID = UUID()
                        })
                })
            VStack {
                HomeHeader(isChanged: $atPortfolio, showPortfolioView: $showPortfolioView)

                if isFirstLoadingAtPricesPage() {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    HomeStatisticsView(statistics: viewModel.statistics, atPortfolio: $atPortfolio)
                    SearchBarView(searchText: $viewModel.searchText)

                    if !atPortfolio {
                        listHeaderView
                        ListView(
                            coins: viewModel.inSearchMode
                            ? viewModel.filterCoins
                            : viewModel.allCoins
                        ) {
                            if !viewModel.inSearchMode {
                                loaderView
                                    .task {
                                        await viewModel.fetchCoins()
                                    }
                            }
                        }
                        .refreshable {
                            await viewModel.onRefresh()
                        }
                        .transition(.move(edge: .leading))
                    } else {
                        if havePortfolioCoins() {
                            listHeaderView
                            ListView(coins: viewModel.portfolioCoins, showHolidngsColumn: true)
                                .transition(.move(edge: .trailing))
                                .id(UUID())
                        } else {
                            emptyPortfolioView
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchCoins()
            }
        }
    }
}

// MARK: - Subviews

private extension HomeView {
    private var listHeaderView: some View {
        HStack {
            Text("Coin")
            Spacer()
            Text(atPortfolio ? "Holdings" : "")
            Text("Price")
                .frame(
                    width: UIScreen.main.bounds.width / 3.5,
                    alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }

    private var loaderView: some View {
        HStack {
            ProgressView()
                .id(UUID())
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var emptyPortfolioView: some View {
        Text("Portfolio is empty")
            .font(.subheadline)
            .bold()
            .foregroundStyle(Color.theme.secondaryText)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Helpers

private extension HomeView {
    private func isFirstLoadingAtPricesPage() -> Bool {
        viewModel.isLoading && viewModel.page == 1 && !atPortfolio
    }

    private func havePortfolioCoins() -> Bool {
        !viewModel.portfolioCoins.isEmpty
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        HomeView(viewModel: HomeViewModel())
    }
}
