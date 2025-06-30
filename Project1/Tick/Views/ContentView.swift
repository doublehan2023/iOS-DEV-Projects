//
//  ContentView.swift
//  Tick
//
//  Created by hannah wang on 6/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerModel = TimerModel(goal: 60)

    var body: some View {
        ZStack {
           
            Color(
                red: 137/255, green: 207/255, blue: 240/255
            ).ignoresSafeArea()

            VStack(spacing: 40) {
                ProgressBarView(progress: $timerModel.progress, goal: $timerModel.goal)

                HStack(spacing: 30) {
                    Button(timerModel.isRunning ? "Pause" : "Start") {
                        timerModel.isRunning ? timerModel.pause() : timerModel.start()
                    }
                    .padding()
                    .frame(width: 100)
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1))

                    Button("Reset") {
                        timerModel.reset()
                    }
                    .padding()
                    .frame(width: 100)
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

