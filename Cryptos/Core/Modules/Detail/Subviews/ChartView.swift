//
//  ChartView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 25.07.2024.
//

import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let startingDate: Date
    private let endingDate: Date
    private let maxY: Double
    private let minY: Double

    @State private var percentage: CGFloat = 0

    private let lineColor: Color

    init(coin: Coin) {
        self.data = coin.sparklineIn7D.price

        maxY = data.max() ?? 0
        minY = data.min() ?? 0

        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange >= 0 ? Color.theme.green : Color.theme.red

        endingDate = Date(string: coin.lastUpdated)
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }

    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(
                    chartYAxis
                        .padding(.horizontal, 4)
                    , alignment: .leading)
            chartDatesView
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            withAnimation(.linear(duration: 2.0).delay(0.2)) {
                percentage = 1.0
            }
        }
    }
}

// MARK: - Subviews

private extension ChartView {
    var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height

                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.3), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }

    var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }

    var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations)
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations)
            Spacer()
            Text(minY.formattedWithAbbreviations)
        }
    }

    var chartDatesView: some View {
        HStack {
            Text("\(startingDate.asShortDateString)")
            Spacer()
            Text("\(endingDate.asShortDateString)")
        }
    }
}

#Preview {
    ChartView(coin: Coin.mock)
}
