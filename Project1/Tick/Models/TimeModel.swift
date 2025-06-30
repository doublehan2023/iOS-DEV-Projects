//
//  TimeModel.swift
//  Tick
//
//  Created by hannah wang on 6/28/25.
//

import Foundation
import Combine
import AVFoundation
import AudioToolbox

class TimerModel: ObservableObject {
    @Published var progress: TimeInterval
    @Published var goal: Double
    @Published var isRunning = false

    private var timer: Timer?
    private var SoundID: SystemSoundID = 1005
    
    

    init(goal: Double = 60) {
        self.goal = goal
        self.progress = goal
    }

    func start() {
        guard !isRunning else { return }
        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            DispatchQueue.main.async {
                if self.progress > 0 {
                    self.progress -= 1
                } else {
                    self.timerFinished()
                }
            }
        }
    }

    func pause() {
        timer?.invalidate()
        isRunning = false
    }

    func reset() {
        timer?.invalidate()
        progress = goal
        isRunning = false
    }
    
    private func SoundSetup() {
        SoundID = 1005
    }
    
    private func timerFinished() {
        timer?.invalidate()
        isRunning = false
        triggerAlarm()
        
    }
    
    private func triggerAlarm() {
        AudioServicesPlaySystemSound(1521)
        for i in 0..<3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                        AudioServicesPlaySystemSound(self.SoundID)
                    }
                }
    }
}
