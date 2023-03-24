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
                        Text("Description of \(item)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Items")
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView: View {
    let item: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.primary)
            Text("This is the detail view for \(item)")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle(item)
        .navigationBarTitleDisplayMode(.inline)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
