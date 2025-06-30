//
//  ProgressBarView.swift
//  Tick
//
//  Created by han wang on 6/27/25.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: TimeInterval
    @Binding var goal: Double
    
    var body: some View {
        ZStack{
            Circle().stroke(
                style: StrokeStyle(
                    lineWidth: 20,
                    lineCap: .butt,
                    dash: [2,6])
            ).fill(.gray)
                .rotationEffect(Angle(degrees: -90))
                .frame(
                    width: 300,
                    height: 300
                )
            
            Circle()
                .trim(from: 0, to: 1 - progress/goal)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .butt,
                        dash: [2, 6]
                    )
                )
                .fill(Color(red: 0/255, green: 64/255, blue: 255/255))
                .animation(.linear(duration: 0.5), value: progress)
                .rotationEffect(.degrees(-90))
                .frame(width: 300, height: 300)
            
            Text(timeString(from: progress))
                            .font(.system(size: 40, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
        }
    }
    
    func timeString(from time: TimeInterval) -> String {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
}

#Preview {
    ProgressBarView(
        progress: .constant(45), goal: .constant(60)
    )
}
