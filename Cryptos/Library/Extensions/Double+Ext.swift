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

    var formattedWithAbbreviations: String {
        let num = abs(Double(self))
        let sign = self < 0 ? "-" : ""
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asTruncatedNumberString
            return "\(sign)\(stringFormatted)Tr"

        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asTruncatedNumberString
            return "\(sign)\(stringFormatted)Bn"

        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asTruncatedNumberString
            return "\(sign)\(stringFormatted)M"

        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asTruncatedNumberString
            return "\(sign)\(stringFormatted)K"

        case 0...:
            return self.asTruncatedNumberString

        default:
            return "\(sign)\(self)"
        }

    }
}
