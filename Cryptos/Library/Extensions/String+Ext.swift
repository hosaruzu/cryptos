//
//  String+Ext.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 25.07.2024.
//

import Foundation

extension String {
    var removingHTMLOccurencies: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
