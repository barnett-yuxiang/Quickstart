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
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
    ]

    private let items: [Item] = [
        Item(title: "Multi-Thread", view: AnyView(MultiThreadItemView())),
        Item(title: "Image Load", view: AnyView(ImageItemView())),
        Item(title: "Feed List", view: AnyView(FeedListItemView()))
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Fixed title header
                Text("Quickstart Items")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.blue.opacity(0.1))
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )

                // Scrollable grid content
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(items) { item in
                            NavigationLink {
                                item.view
                                    .navigationTitle(item.title)
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                Text(item.title)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, minHeight: 45)
                                    .background(Color.blue.opacity(0.2))
                                    .foregroundColor(.black)
                                    .cornerRadius(6)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
