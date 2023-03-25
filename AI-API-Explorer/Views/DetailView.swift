//
//  DetailView.swift
//  AI-API-Explorer
//
//  Created by Sourav on 24/3/23.
//

import SwiftUI

struct DetailView: View {
    let item: String

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.purple, .pink, .orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                Text(item)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("This is the detail view for \(item)")
                    .font(.body)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .navigationTitle(item)
        .navigationBarTitleDisplayMode(.inline)
    }
}
