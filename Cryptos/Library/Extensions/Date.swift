//
//  Date.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 25.07.2024.
//

import Foundation

extension Date {
    init(string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: string) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    var asShortDateString: String {
        shortFormatter.string(from: self)
    }
}
