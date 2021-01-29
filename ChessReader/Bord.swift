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
            if ["LR", "LN", "LB", "LK", "LQ", "LB", "LN", "LR", "LP"].contains(bord[row][col]) {
            
            }
        }
        return [[1]]
    }
    
    
}

