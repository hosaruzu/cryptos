//
//  ImageView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 15.07.2024.
//

import SwiftUI

struct ImageView: View {

    var urlString: String
    var width: CGFloat = 30
    var height: CGFloat = 30

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { result in
            if let image = result.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if result.error != nil {
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.theme.secondaryText)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    ImageView(urlString: Coin.mock.image)
}
