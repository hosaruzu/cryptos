//
//  StatisticView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 15.07.2024.
//

import SwiftUI

struct StatisticView: View {

    let statistic: Statistic

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(
                        degrees: (statistic.percentageChange ?? 0).isLessThanOrEqualTo(0)
                        ? 180
                        : 0))
                Text(statistic.percentageChange?.asTruncatedPercentString ?? "%0.0")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                (statistic.percentageChange ?? 0).isLessThanOrEqualTo(0)
                ? Color.theme.red
                : Color.theme.green)
            .opacity(statistic.percentageChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    Group {
        StatisticView(statistic: Statistic.mock[0])
            .previewLayout(.sizeThatFits)
        StatisticView(statistic: Statistic.mock[1])
            .previewLayout(.sizeThatFits)
        StatisticView(statistic: Statistic.mock[2])
            .previewLayout(.sizeThatFits)
    }
    .padding(.vertical, 10)
}
