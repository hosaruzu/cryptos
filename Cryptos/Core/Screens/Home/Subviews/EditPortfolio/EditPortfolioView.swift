//
//  EditPortfolioView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 22.07.2024.
//

import SwiftUI

struct EditPortfolioView: View {

    @Environment(\.dismiss) var dissmiss
    @ObservedObject var viewModel: HomeViewModel
    @State var selectedCoin: Coin?
    @State var quantityText: String = ""
    @State var showCheckmark: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinsMenu

                    if selectedCoin != nil {
                        portfolioForm
                    }
                }
            }
            .navigationTitle("Edit portfolio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dissmiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .tint(Color.theme.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveButtonTapped()
                    } label: {
                        HStack {
                            Image(systemName: showCheckmark ? "checkmark.square.fill" : "checkmark")
                                .font(.title3)
                                .tint(Color.theme.green)
                        }
                    }
                    .opacity(selectedCoin != nil
                             && selectedCoin?.currentHoldings != Double(quantityText)
                             ? 1.0
                             : 0.0)
                }
            }
        }
    }
}

// MARK: - Subviews

private extension EditPortfolioView {
    var coinsMenu: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.inSearchMode ? viewModel.filterCoins : viewModel.portfolioCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                updateSelectedCoin(coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin == coin
                                    ? Color.theme.accent
                                    : .clear,
                                    lineWidth: 2
                                )
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }

    var portfolioForm: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals ?? "No data")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex. 1.4", text: $quantityText)
                    .onChange(of: quantityText) { newValue in
                        quantityText = newValue.replacingOccurrences(of: ",", with: ".")
                    }
                    .foregroundStyle(Color.theme.accent)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            if !quantityText.isEmpty {
                HStack {
                    Text("Current price:")
                    Spacer()
                    Text(getCurrentPrice())
                }
            }
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }
}

// MARK: - Private methods

private extension EditPortfolioView {
    func getCurrentPrice() -> String {
        guard let quantity = Double(quantityText),
              let currentPrice = selectedCoin?.currentPrice
        else { return "No data"}
        let result = currentPrice * quantity
        return result.asCurrencyWith6Decimals
    }

    func saveButtonTapped() {
        guard let quantity = Double(quantityText),
              let selectedCoin
        else { return }
        viewModel.updatePortfolio(selectedCoin, amount: quantity)

        withAnimation(.bouncy) {
            showCheckmark = true
        }
        withAnimation(.spring.delay(1)) {
            showCheckmark = false
            removeSelectedCoin()
        }
    }

    func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }

    private func updateSelectedCoin(_ coin: Coin) {
        selectedCoin = coin
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }) {
            let amount = portfolioCoin.currentHoldings
            quantityText = "\(amount ?? 0.0)"
        } else {
            quantityText = ""
        }
    }
}

#Preview {
    EditPortfolioView(viewModel: HomeViewModel())
}
