//
//  CircleButtonAnimationView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool

    var body: some View {
        Circle()
            .scale(animate ? 1.0 : 0.0)
            .stroke(Color.theme.accent, style: .init(lineWidth: 1.0))
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 1.0) : .none, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
        .frame(width: 100, height: 100)
}
