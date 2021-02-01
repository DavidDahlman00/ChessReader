//
//  Bord.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

class Bord: ObservableObject {

    @Published var bord : [[String]]
    @Published var activityBord : [[String]]
    var playerToGo : String = "light"
    @Published var schack : [Bool] = [false, false]
    
    init() {

        bord = [["BR", "BN", "BB", "BK", "BQ", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LK", "LQ", "LB", "LN", "LR"]]
        
        activityBord = [["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",]]
        
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
    
    func recetActivityBord() {
        for row in 0...7 {
            for col in 0...7 {
                activityBord[row][col] = "none"
            }
        }
    }
    
    func squareTuched(row: Int, col: Int)  {
        if playerToGo == "light" {
            if ["LR", "LN", "LB", "LK", "LQ", "LB", "LN", "LR", "LP"].contains(bord[row][col]){
                recetActivityBord()
                activityBord[row][col] = "active"
            }
        }
    }

    

}
