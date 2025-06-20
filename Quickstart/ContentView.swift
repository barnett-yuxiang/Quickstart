//
//  ContentView.swift
//  Quickstart
//
//  Created by yuxiang on 2025/6/19.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let view: AnyView
}

struct ContentView: View {
    private let columns = [
        GridItem(.flexible()), GridItem(.flexible()),
    ]

    private let items: [Item] = [
        Item(title: "Multi-Thread", view: AnyView(MultiThreadItemView()))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items) { item in
                        NavigationLink {
                            item.view
                                .navigationTitle(item.title)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            Text(item.title)
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Quickstart Items")
        }
    }
}

#Preview {
    ContentView()
}
