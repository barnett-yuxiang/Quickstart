//
//  MultiThreadItemView.swift
//  Quickstart
//
//  Created by yuxiang on 2025/6/20.
//

import SwiftUI

struct MultiThreadItemView: View {
    @State private var resultText = "Ready"

    var body: some View {
        VStack(spacing: 20) {
            Text(resultText)
                .font(.title2)
                .padding()

            Button("Start Background Task") {
                runBackgroundTask()
            }
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(8)

            Spacer()
        }
        .padding()
    }

    private func runBackgroundTask() {
        resultText = "Running"
        DispatchQueue.global(qos: .userInitiated).async {
            let result = heavyCompute()
            DispatchQueue.main.async {
                resultText = "Done: \(result)"
            }
        }
    }

    private func heavyCompute() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Completed"
    }
}
