//
//  SearchAndDetail.swift
//  AI-API-Explorer
//
//  Created by Sourav on 25/3/23.
//

import SwiftUI

struct SearchAndDetailView: View {
    @State private var searchText = ""
    @State private var detailText = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText, onSearchBarTap: onSearchBarTap)

            Spacer()
                .frame(height: 40)

            Spacer()

            Text("\(detailText) ")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()

            Spacer()
        }
    }

    private func onSearchBarTap() {
        let rep = TextCompletionRepository()
        detailText = "Searching about \(searchText) ..."
        rep.getTextCompletion(text: "write about \(searchText) within 100 words") { result in
            print(result)
            switch result {
            case .success(let completionText):
                detailText = completionText.choices.first?.text ?? "No completion text."
            case .failure:
                detailText = "API fetch failed."
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var onSearchBarTap: (() -> Void)

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal, 24)
            Button(action: {
                print("Search button tapped.")
                onSearchBarTap()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}
