//
//  ContentView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            VStack {
                Text("Accent")
                    .foregroundStyle(Color.theme.accent)
                Text("Green")
                    .foregroundStyle(Color.theme.green)
                Text("Red")
                    .foregroundStyle(Color.theme.red)
            }
        }
    }
}

#Preview {
    ContentView()
}
