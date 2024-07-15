//
//  Double+Ext.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 11.07.2024.
//

import Foundation

extension Double {

    private func formatAsCurrency(_ fraction: Int, separator: Bool = false) -> String {
        let value = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.usesGroupingSeparator = separator
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = fraction
        return formatter.string(from: value) ?? "0.00"
    }

    var asCurrencyWith6Decimals: String {
        return formatAsCurrency(6)
    }

    var asCurrencyWith2Decimals: String {
        return formatAsCurrency(2)
    }

    var asTruncatedNumberString: String {
        return String(format: "%.2f", self)
    }

    var asTruncatedPercentString: String {
        return asTruncatedNumberString + "%"
    }
}
