//
//  GameManager.swift
//  Swift2048
//
//  Created by hannah wang on 6/30/25.
//

import Foundation
import SwiftUI

class GameManager: ObservableObject {
    @Published var grid: [[Tile?]] = Array(repeating: Array(repeating: nil, count: 4), count: 4)
    @Published var score: Int = 0

    init() {
        startGame()
    }

    func startGame() {
        grid = Array(repeating: Array(repeating: nil, count: 4), count: 4)
        spawnTile()
        spawnTile()
        score = 0
    }

    func spawnTile() {
        let emptyPositions = grid.enumerated().flatMap { row, cols in
            cols.enumerated().compactMap { col, tile in
                tile == nil ? (row, col) : nil
            }
        }

        guard let (x, y) = emptyPositions.randomElement() else { return }

        let value = Bool.random() ? 2 : 4
        grid[x][y] = Tile(value: value, x: x, y: y)
    }
    
    func isGameOver() -> Bool {
        
        //check for any empty tile
        for row in grid {
            for tile in row{
                if tile == nil {
                    return false
                }
            }
        }
        //check for any mergable adjacent tiles
        for i in 0..<4 {
            for j in 0..<4{
                if j < 3, let current = grid[i][j], let next = grid[i][j+1], current.value == next.value{
                    return false
                }
                if i < 3, let current = grid[i][j], let next = grid[i+1][j], current.value == next.value{
                    return false
                }
            }
        }
        
        return true
    }

    func swipe(_ direction: Direction) {
        var moved = false
        
        switch direction {
            case .left:
                moved = moveLeft()
            case .right:
                rotateGridClockwise()
                rotateGridClockwise()
                moved = moveLeft()
                rotateGridClockwise()
                rotateGridClockwise()
            case .up:
                rotateGridCounterClockwise()
                moved = moveLeft()
                rotateGridClockwise()
            case .down:
                rotateGridClockwise()
                moved = moveLeft()
                rotateGridCounterClockwise()
            }

            if moved {
                spawnTile()
            }
        
    }

    func moveLeft() -> Bool {
        var moved = false
        for row in 0..<4 {
            var newRow: [Tile] = grid[row].compactMap {$0}
            
            var MergeRow: [Tile?] = []
            var i = 0
            while i < newRow.count {
                if i < newRow.count - 1 && newRow[i].value == newRow[i+1].value {
                    let mergeValue = newRow[i].value * 2
                    score += mergeValue
                    MergeRow.append(Tile(value: mergeValue, x: row, y: MergeRow.count))
                    i += 2
                    moved = true
                }else {
                    MergeRow.append(Tile(value: newRow[i].value, x: row, y: MergeRow.count))
                    if newRow[i].y != MergeRow.count {
                        moved = true
                    }
                    i += 1
                }
            }
            
            while MergeRow.count < 4 {
                MergeRow.append(nil)
            }
            
            grid[row] = MergeRow
            
        }
        return moved
    }
    
    
    func rotateGridClockwise() {
        var newGrid: [[Tile?]] = Array(repeating: Array(repeating: nil, count: 4), count: 4)

        for i in 0..<4 {
            for j in 0..<4 {
                newGrid[j][3 - i] = grid[i][j]
            }
        }

        grid = newGrid
    }
    
    func rotateGridCounterClockwise() {
        var newGrid: [[Tile?]] = Array(repeating: Array(repeating: nil, count: 4), count: 4)

        for i in 0..<4 {
            for j in 0..<4 {
                newGrid[3 - j][i] = grid[i][j]
            }
        }

        grid = newGrid
    }
    
    enum Direction {
        case up, down, left, right
    }
}
