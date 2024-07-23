//
//  HomeStatisticsView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 15.07.2024.
//

import SwiftUI

struct HomeStatisticsView: View {

    let statistics: [Statistic]
    @Binding var atPortfolio: Bool

    var body: some View {
        HStack {
            ForEach(statistics) { statistics in
                StatisticView(statistic: statistics)
                    .frame(width: UIScreen.main.bounds.width / 3.33)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: atPortfolio ? .trailing : .leading)
        .animation(.smooth, value: atPortfolio)
    }
}

#Preview {
    HomeStatisticsView(statistics: Statistic.mock, atPortfolio: .constant(false))
}
