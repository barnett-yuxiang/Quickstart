//
//  NetworkFetchItemView.swift
//  Quickstart
//
//  Created by yuxiang on 2025/6/21.
//

import SwiftUI

// Responsible for fetching and displaying simplified key information from web pages
struct NetworkFetchItemView: View {
    @State private var title: String = "Loading…"
    @State private var summary: String = ""
    @State private var loading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            if loading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let errorMessage {
                Label(errorMessage, systemImage: "exclamationmark.triangle")
                    .foregroundColor(.red)
            } else {
                Text(title)
                    .font(.title2.bold())

                if !summary.isEmpty {
                    Text(summary)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(24)
        .task { await fetchPage() }  // Automatically triggered when view appears
    }

    // MARK: - Networking

    private func fetchPage() async {
        guard let url = URL(string: "https://example.com/") else {
            errorMessage = "Bad URL"
            loading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            guard let html = String(data: data, encoding: .utf8) else {
                throw URLError(.cannotDecodeContentData)
            }

            // —— Only perform very lightweight regex extraction —— //
            title =
                extract(regex: "<title>(.*?)</title>", from: html)
                ?? "No <title>"
            summary =
                extract(regex: "<p>(.*?)</p>", from: html)?
                .replacingOccurrences(
                    of: "<[^>]+>",
                    with: "",
                    options: .regularExpression
                )  // Remove remaining tags
                ?? "No paragraph found"

        } catch {
            errorMessage = error.localizedDescription
        }
        loading = false
    }

    // Simple regex matching, returns the first capture group
    private func extract(regex pattern: String, from text: String) -> String? {
        if let range = text.range(of: pattern, options: .regularExpression) {
            let raw = String(text[range])
            // Remove the entire match, but keep the parentheses capture
            if let innerRange = raw.range(
                of: pattern,
                options: .regularExpression
            ) {
                return String(raw[innerRange])
            }
            // Could also use NSRegularExpression directly, but keeping it simple here
        }
        return nil
    }
}
