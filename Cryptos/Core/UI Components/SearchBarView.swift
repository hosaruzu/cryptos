//
//  SearchBarView.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 15.07.2024.
//

import SwiftUI

struct SearchBarView: View {

    @Binding var searchText: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            HStack {
                searchIcon
                searchTextField
                if isFocused && !searchText.isEmpty {
                    clearButton
                }
            }
            .font(.headline)
            .padding()
            .cornerRadius(20)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.theme.accent, lineWidth: 2)
                    .animation(.easeOut(duration: 0.3), value: isFocused)
            )

            Spacer(minLength: isFocused ? 8 : 0)
            if isFocused {
                cancelButton
            }
        }
        .padding()
    }
}

// MARK: - Subviews

private extension SearchBarView {
    private var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .foregroundStyle(isFocused ? Color.theme.accent : Color.theme.secondaryText)
            .animation(.easeOut(duration: 0.5), value: isFocused)
    }

    private var searchTextField: some View {
        ZStack(alignment: .leading) {
            if searchText.isEmpty {
                Text("Search by name or symbol...")
                    .foregroundStyle(Color.theme.secondaryText)
            }
            TextField("", text: $searchText)
                .foregroundStyle(Color.theme.primaryText)
                .focused($isFocused)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
        }
    }

    private var clearButton: some View {
        Button {
            searchText = ""
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(isFocused ? Color.theme.accent : Color.theme.secondaryText)
        }
        .transition(
            AnyTransition.asymmetric(
                insertion:
                        .opacity.animation(
                            .easeInOut(duration: 0.2)
                        ),
                removal: .opacity.animation(
                    .easeInOut(duration: 0.1)
                )
            )
        )
    }

    private var cancelButton: some View {
        Button {
            searchText = ""
            isFocused.toggle()
        } label: {
            Text("Cancel")
        }
        .transition(
            AnyTransition.asymmetric(
                insertion:
                        .opacity.animation(
                            .easeInOut(duration: 0.3)
                            .delay(0.1)
                        ),
                removal: .identity)
        )
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
