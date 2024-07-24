//
//  InfoVGrid.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 24.07.2024.
//

import SwiftUI

struct InfoVGrid: View {

    let statistics: [Statistic]

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30

    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing
        ) {
            ForEach(statistics) { stat in
                StatisticView(statistic: stat)
            }
        }
    }
}

#Preview {
    InfoVGrid(statistics: Statistic.mock)
}
