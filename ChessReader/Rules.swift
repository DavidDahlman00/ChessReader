//
//  Rules.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

struct Rules {
    
    func WhitePawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if bord[row - 1][col] == "" && row > 0  {
            moveList.append([row - 1, col,])
            if bord[row - 2][col] == "" && row == 6 {
                moveList.append([row - 2, col,])
            }
        }
        if ["BR", "BN", "BB", "BK", "BQ", "BB", "BN", "BR"].contains(bord[row - 1][col - 1]) && col > 0 && row > 0 {
            moveList.append([row - 1, col - 1])
        }
        if ["BR", "BN", "BB", "BK", "BQ", "BB", "BN", "BR"].contains(bord[row - 1][col + 1]) && col < 7 && row > 0 {
            moveList.append([row - 1, col - 1])
        }
        return moveList
    }
}
