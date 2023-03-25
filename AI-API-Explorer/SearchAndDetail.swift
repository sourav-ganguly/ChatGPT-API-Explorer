//
//  SearchAndDetail.swift
//  AI-API-Explorer
//
//  Created by Sourav on 25/3/23.
//

import SwiftUI

struct SearchAndDetail: View {
    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)

            Spacer()

            Text("Detail Label View")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal, 24)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}
