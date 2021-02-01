//
//  Bord.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

class Bord: ObservableObject {

    @Published var bord : [[String]]
    var tuchedSquare : [Int]? = nil
    var playerToGo : String = "light"
    @Published var schack : [Bool] = [false, false]
    
    init() {

        bord = [["BR", "BN", "BB", "BK", "BQ", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LK", "LQ", "LB", "LN", "LR"]]
        
        
    }
    
    func getPlayerToGo() -> String {
        return playerToGo
    }
    
    func changePlayerToGo()  {
        if playerToGo == "light" {
            playerToGo = "dark"
        } else {
            playerToGo = "light"
        }
    }
    
    func changeTuchedSquare(row: Int, col: Int)  {
        if true {
            tuchedSquare = [row, col]
        }
    }

    

}
