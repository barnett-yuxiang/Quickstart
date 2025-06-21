//
//  ImageItemView.swift
//  Quickstart
//
//  Created by yuxiang on 2025/6/21.
//

import SwiftUI

struct ImageItemView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Local Assets Image
                Image("sample")  // Place sample.png/PDF into Assets
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 220
                    )
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .overlay(
                        Text("From Assets")
                            .font(.caption)
                            .padding(6)
                            .background(.ultraThinMaterial),
                        alignment: .bottomTrailing
                    )

                // Remote URL Image
                AsyncImage(
                    url: URL(
                        string:
                            "https://www.yuli-kamakura.com/assets/trace-compare.jpeg"
                    )
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                    case .failure(let error):
                        let _ = print("AsyncImage error:", error)
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 220
                )
                .cornerRadius(12)
                .shadow(radius: 4)
                .overlay(
                    Text("AsyncImage Remote Loading")
                        .font(.caption)
                        .padding(6)
                        .background(.ultraThinMaterial),
                    alignment: .bottomTrailing
                )
            }
            .padding()
        }
    }
}
