//
//  FeedListItemView.swift
//  Quickstart
//
//  Created by yuxiang on 2025/6/21.
//

import SwiftUI

// Simple Feed data model
struct Feed: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
}

// Mock 10 items of data
private let mockFeeds: [Feed] = (1...10).map {
    Feed(
        title: "Feed Title \($0)",
        subtitle:
            "Here is a longer description for feed item \($0), demonstrating dynamic height.",
        imageName: "sample"
    )
}

struct FeedListItemView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24, pinnedViews: []) {  // LazyVStack handles lazy loading
                ForEach(mockFeeds) { feed in
                    FeedCard(feed: feed)
                        .onAppear { print("► appear:", feed.title) }
                        .onDisappear { print("◄ disappear:", feed.title) }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        }
        // iOS 17+ new scroll indicators style, optional
        .scrollIndicators(.hidden)
    }
}

private struct FeedCard: View {
    let feed: Feed

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 1. Large image (height 220)
            Image(feed.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, minHeight: 220, maxHeight: 220)
                .clipped()
                .cornerRadius(14)

            // 2. Title & subtitle
            Text(feed.title)
                .font(.headline)
            Text(feed.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // 3. Action button examples
            HStack {
                Button(action: {}) {
                    Label("Like", systemImage: "hand.thumbsup")
                }
                Spacer()
                Button(action: {}) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            .font(.subheadline)
            .padding(.top, 4)
        }
        .padding()
        .background(.ultraThinMaterial)  // Frosted glass effect
        .cornerRadius(20)
        .shadow(radius: 4)
    }
}
