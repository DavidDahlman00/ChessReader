//
//  Bord.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation
struct Bord {
    var playerToGo: String = "white"
    func movList(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        if playerToGo == "white"{
            if ["WR", "WN", "WB", "WK", "WQ", "WB", "WN", "WR", "WP"].contains(bord[row][col]) {
            
            }
        }
        return [[1]]
    }
    
    
}

