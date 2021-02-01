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
    var activeSquare: [Int]? = nil
    var activePice: String? = nil
    
    
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
        activeSquare = nil
        activePice = nil
    }
    
    func squareTuched(row: Int, col: Int)  {
        if playerToGo == "light" {
            switch activityBord[row][col] {
            case "active":
                recetActivityBord()
            case "inMoveList":
                if activeSquare != nil{
                    bord[activeSquare![0]][activeSquare![1]] = ""
                }
                if activePice != nil {
                    bord[row][col] = activePice!
                }
                recetActivityBord()
                changePlayerToGo()
            case "none":
                if ["LR", "LN", "LB", "LK", "LQ", "LB", "LN", "LR", "LP"].contains(bord[row][col]){
                    recetActivityBord()
                    activityBord[row][col] = "active"
                    activeSquare = [row, col]
                    activePice = bord[row][col]
                    let rules = Rules()
                    var moveList = [[Int]]()
                    
                    switch bord[row][col] {
                        case "LK":
                            moveList = rules.LightKing(bord: bord, row: row, col: col)
                        case "LN":
                            moveList = rules.LightKnight(bord: bord, row: row, col: col)
                        case "LP":
                            moveList = rules.LightPawn(bord: bord, row: row, col: col)
                        default:
                            moveList = [[Int]]()
                        }
                    
                        for move in moveList {
                            activityBord[move[0]][move[1]] = "inMoveList"
                        }
                }
            default:
                recetActivityBord()
            }

        }
    }
}
