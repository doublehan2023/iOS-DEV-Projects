//
//  Tile.swift
//  Swift2048
//
//  Created by hannah wang on 6/30/25.
//

import Foundation

struct Tile: Identifiable {
    let id = UUID()
    var value: Int
    var x: Int
    var y: Int
}
