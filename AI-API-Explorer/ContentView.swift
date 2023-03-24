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
                    Text(item)
                }
            }
            .navigationTitle("Items")
        }
    }
}

struct DetailView: View {
    let item: String

    var body: some View {
        Text("Detail View for \(item)")
            .navigationTitle(item)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
