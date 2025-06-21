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

            Button("Thread Communication") {
                runThreadCommunication()
            }
            .padding()
            .background(Color.orange.opacity(0.3))
            .cornerRadius(8)

            Spacer()
        }
        .padding()
    }

    private func runBackgroundTask() {
        resultText = "Running"
        DispatchQueue.global(qos: .userInitiated).async {
            let result = heavyCompute()

            // Sleep for 1 second before returning to main thread to refresh UI
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                resultText = "Done: \(result)"
            }
        }
    }

    private func heavyCompute() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Completed"
    }

    // Two-thread communication example — Thread A ➜ Thread B
    private func runThreadCommunication() {
        resultText = "Thread communication started"

        let semaphore = DispatchSemaphore(value: 0)  // Semaphore initialized to 0
        var sharedValue = 0  // Shared data

        // Thread A: Write value and signal
        DispatchQueue.global(qos: .background).async {
            sharedValue = 10
            semaphore.signal()  // Notify Thread B
        }

        // Thread B: Wait for signal -> Read value and increment by 1
        DispatchQueue.global(qos: .background).async {
            semaphore.wait()  // Block until signal is received
            sharedValue += 1  // Critical operation
            let final = sharedValue

            // Sleep for 1 second before returning to main thread to refresh UI
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                resultText = "Final value: \(final)"  // Should output 11
            }
        }

    }
}
