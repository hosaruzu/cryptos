//
//  CryptosApp.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import SwiftUI

@main
struct CryptosApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
    @State var showLaunchView = true

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView(viewModel: homeViewModel)
                }
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
