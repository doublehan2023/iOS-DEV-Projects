//
//  ContentView.swift
//  Swift2048
//
//  Created by hannah wang on 6/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameManager = GameManager()
    @State private var showGameOver = false
    
    var body: some View {
        ZStack{
            
            Color(red: 255/255, green: 253/255, blue: 208/245).ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Title
                Text("2048 Game")
                    .font(.largeTitle)
                    .bold()

                // Score box
                VStack {
                    Text("Score")
                        .font(.headline)
                    Text("\(gameManager.score)")
                        .font(.title2)
                        .bold()
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                // Game Board
                GameBoardView(gameManager: gameManager,
                showGameOver: $showGameOver)

                // Restart Button
                Button("Restart") {
                    gameManager.startGame()
                    showGameOver = false
                }
                .font(.title3)
                .bold()
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                Spacer() // Push everything to the top
            }
            .padding()
        }
        
        .alert("Game Over!", isPresented: $showGameOver){
            Button("Restart") {
                           gameManager.startGame()
                           showGameOver = false
            }
        }message: {
            Text("No more moves left")
        }
        }
        
        
}



#Preview {
    ContentView()
}
