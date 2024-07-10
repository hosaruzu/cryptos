//
//  Color+Ext.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color.accentColor
    let background = Color.background
    let green = Color.crGreen
    let red = Color.crRed
    let secondaryText = Color.crSecondaryText
}
