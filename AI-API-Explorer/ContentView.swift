//
//  ContentView.swift
//  AI-API-Explorer
//
//  Created by Sourav on 24/3/23.
//

import SwiftUI

struct ContentView: View {
    let items = ["Item 1", "Item 2", "Item 3"]

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                NavigationLink(destination: DetailView(item: item)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.primary)
                            .padding(.vertical, 4)
                    }
                    .padding(.vertical, 8)
                }
                .padding(.vertical, 8)
                .cornerRadius(10)
            }
            .navigationTitle("Items")
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
