//
//  TileView.swift
//  Swift2048
//
//  Created by hannah wang on 6/30/25.
//

import SwiftUI

struct TileView: View {
    let tile: Tile?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(tile?.value ?? 0))

            if let value = tile?.value, value != 0 {
                Text("\(value)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .frame(width: 70, height: 70)
    }
}


extension Color {
    init(_ value: Int) {
        switch value {
        case 2: self = .yellow
        case 4: self = .orange
        case 8: self = .red
        case 16: self = .purple
        case 32: self = .blue
        case 64: self = .green
        case 128: self = .pink
        case 256: self = .brown
        case 512: self = .cyan
        case 1024: self = .indigo
        case 2048: self = .black
        default: self = .gray.opacity(0.2)
        }
    }
}

#Preview {
    TileView(tile: Tile(value: 4, x: 0, y: 0))
}
