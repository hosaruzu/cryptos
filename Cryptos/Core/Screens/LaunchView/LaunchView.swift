//
//  LaunchView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 25.07.2024.
//

import SwiftUI

struct LaunchView: View {

    @State var animate = false
    @Binding var showLaunchView: Bool

    var body: some View {
        ZStack {
            Color.launchBackground
                .ignoresSafeArea()
            Image(.logo)
                .resizable()
                .frame(width: 100, height: 100)
                .rotationEffect(animate ? Angle(degrees: 360) : Angle(degrees: 0))
                .animation(.spring(duration: 2).repeatForever(autoreverses: false), value: animate)
                .opacity(showLaunchView ? 1 : 0)
        }
        .task {
            try? await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)
            showLaunchView = false
        }
        .onAppear {
            animate.toggle()
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
