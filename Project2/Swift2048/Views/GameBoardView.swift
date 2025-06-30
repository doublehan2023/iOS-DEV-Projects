//
//  GameBoardView.swift
//  Swift2048
//
//  Created by hannah wang on 6/30/25.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var gameManager: GameManager
    @Binding var showGameOver: Bool

    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<4, id: \.self) { row in
                HStack(spacing: 8) {
                    ForEach(0..<4, id: \.self) { col in
                        TileView(tile: gameManager.grid[row][col])
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .gesture(
            DragGesture()
                .onEnded { value in
                    let dx = value.translation.width
                    let dy = value.translation.height

                    var direction: GameManager.Direction?
                    
                    if abs(dx) > abs(dy) {
                        direction = dx > 0 ? .right : .left
                    } else {
                        direction = dy > 0 ? .down : .up
                    }
                    
                    if let dir = direction {
                        gameManager.swipe(dir)
                        if gameManager.isGameOver() {
                            showGameOver = true
                        }
                    }
                }
        )
    }
}


