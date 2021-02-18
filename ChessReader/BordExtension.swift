//
//  BordExtension.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-18.
//

import Foundation

extension Bord{
    func squareTuched(row: Int, col: Int)  {
        let pices = [["LB", "LK", "LN", "LP", "LR", "LQ"], ["BB", "BK", "BN", "BP", "BR", "BQ"]]
        let player: Int
        if playerToGo == "Light" {
            player = 0
        }else{
            player = 1
        }
            
    switch activityBord[row][col] {
        case "active":
            recetActivityBord()
        case "inMoveList":
            if activePice == "LK"{
                kingHasMoved[0] = true
            }
            if activePice == "BK" {
                kingHasMoved[1] = true
            }
            if activePice == "LP" && row == 0 {
                promotePawn = true
                promotedPawn = [col, -1]
            }
            if activePice == "BP" && row == 7 {
                promotePawn = true
                promotedPawn = [-1, col]
            }
            
            if activeSquare != nil{
                bord[activeSquare![0]][activeSquare![1]] = ""
            }
            if activePice != nil {
                bord[row][col] = activePice!
            }
            if activePice == "LP" && activeSquare![0] - row == 2 {
                enPassant[0] = col
            }
            if activePice == "BP" && row - activeSquare![0] == 2 {
                enPassant[1] = col
            }
            print(bord[row][col])
            print(activityBord[row][col])
            print("enPassants \(enPassant[0]), \(enPassant[1])")
            if playerToGo == "Light" {
                enPassant[1] = 10
            }else{
                enPassant[0] = 10
            }

            goToNextPlayer()
            print("King move test")
            print(kingHasMoved[0])
            print(kingHasMoved[1])
        case "inEnPassantList":
            if playerToGo == "Light" {
                bord[3][col] = ""
                enPassant[1] = 10
            }else{
                bord[4][col] = ""
                enPassant[1] = 10
            }
            if activeSquare != nil{
                bord[activeSquare![0]][activeSquare![1]] = ""
            }
            if activePice != nil {
                bord[row][col] = activePice!
            }
            goToNextPlayer()
        case "casteling":
            if row == 7 && col == 6 {
                bord[7][4] = ""
                bord[7][5] = "LR"
                bord[7][6] = "LK"
                bord[7][7] = ""
            } else if row == 7 && col == 2{
                bord[7][0] = ""
                bord[7][3] = "LR"
                bord[7][2] = "LK"
                bord[7][4] = ""
            } else if row == 0 && col == 6{
                bord[0][4] = ""
                bord[0][5] = "BR"
                bord[0][6] = "BK"
                bord[0][7] = ""
            } else if row == 0 && col == 2{
                bord[0][0] = ""
                bord[0][3] = "BR"
                bord[0][2] = "BK"
                bord[0][4] = ""
            }
            goToNextPlayer()
        case "none":
            if pices[player].contains(bord[row][col]){
                print("1")
                recetActivityBord()
                activityBord[row][col] = "active"
                print("2")
                activeSquare = [row, col]
                activePice = bord[row][col]
                let rules = Rules()
                var moveList = [[Int]]()
                var enPassantList = [[Int]]()
                switch bord[row][col] {
                    case pices[player][0]:
                        if player == 0 {
                            moveList = rules.lightBishop(bord: bord, checkSchack: true, row: row, col: col)
                        }else{
                            moveList = rules.darkBishop(bord: bord, checkSchack: true, row: row, col: col)
                        }
                        
                    case pices[player][1]:
                        if player == 0 {
                            moveList = rules.lightKing(bord: bord,  checkSchack: true, row: row, col: col)
                            print("///////////////")
                            if rules.shortCastling(bord: self){
                                activityBord[7][6] = "casteling"
                                print("Can short castle")
                            }
                            if rules.longCastling(bord: self){
                                activityBord[7][2] = "casteling"
                                print("Can long castle")
                            }
                        }else{
                            moveList = rules.darkKing(bord: bord, checkSchack: true, row: row, col: col)
                            print("///////////////")
                            if rules.shortCastling(bord: self){
                                activityBord[0][6] = "casteling"
                                print("Can short castle")
                            }
                            if rules.longCastling(bord: self){
                                activityBord[0][2] = "casteling"
                                print("Can long castle")
                            }
                        }
                    case pices[player][2]:
                        if player == 0 {
                            moveList = rules.lightKnight(bord: bord, checkSchack: true, row: row, col: col)
                        }else{
                            moveList = rules.darkKnight(bord: bord, checkSchack: true, row: row, col: col)
                        }
                    case pices[player][3]:
                        if player == 0 {
                            moveList = rules.lightPawn(bord: bord, checkSchack: true, row: row, col: col)
                            enPassantList = rules.lightPawnEnPassant(bord: bord, checkSchack: true,enPassant: enPassant, row: row, col: col)
                        }else{
                            moveList = rules.darkPawn(bord: bord, checkSchack: true, row: row, col: col)
                            enPassantList = rules.darkPawnEnPassant(bord: bord, checkSchack: true, enPassant: enPassant, row: row, col: col)
                        }
                    case pices[player][4]:
                        if player == 0 {
                            moveList = rules.lightRook(bord: bord, checkSchack: true, row: row, col: col)
                        }else{
                            moveList = rules.darkRook(bord: bord, checkSchack: true, row: row, col: col)
                        }
                    case pices[player][5]:
                        if player == 0 {
                            moveList = rules.lightQueen(bord: bord, checkSchack: true, row: row, col: col)
                        }else{
                            moveList = rules.darkQueen(bord: bord, checkSchack: true, row: row, col: col)
                        }
                    default:
                        moveList = [[Int]]()
                    }
                    for move in moveList {
                        activityBord[move[0]][move[1]] = "inMoveList"
                    }
                    for move in enPassantList {
                        activityBord[move[0]][move[1]] = "inEnPassantList"
                        print("enPassant \(move[0]), \(move[1])")
                    }
                
            }
            
        default:
            recetActivityBord()
        }
    }
}
