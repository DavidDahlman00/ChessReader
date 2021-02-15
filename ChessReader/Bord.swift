//
//  Bord.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

class Bord: ObservableObject {

    @Published var bord : [[String]]
    @Published var activityBord : [[String]]
    @Published var promotedPawn: [Int] = [-1, -1]   // -1 = no pawn to promote
    @Published var promotePawn: Bool = false
    var playerToGo : String = "Light"
    @Published var schach : [Bool] = [false, false]
    @Published var schachMate : [Bool] = [false, false]
    @Published var staleMate : [Bool] = [false, false]
    @Published var kingHasMoved : [Bool] = [false, false]
    @Published var drawByRepitation : Bool = false
    var activeSquare: [Int]? = nil
    var activePice: String? = nil
    var enPassant = [10, 10]        // 10 = no en passant move
    var histBord: [[[String]]] = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
    
    
    init() {

        bord = [["BR", "BN", "BB", "BQ", "BK", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
        
        activityBord = [["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",]]
         promotedPawn = [-1, -1]   // -1 = no pawn to promote
        promotePawn = false
        playerToGo = "Light"
        schach  = [false, false]
         schachMate = [false, false]
      staleMate = [false, false]
       kingHasMoved = [false, false]
         drawByRepitation  = false
         activeSquare = nil
         activePice = nil
         enPassant = [10, 10]        // 10 = no en passant move
         histBord = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
        
        histBord[0] = bord
        
    }
    
    func bordToString() -> String {
        var fenText = ""
        for row in 0...7 {
            for col in 0...7 {
                if bord[row][col] != "" {
                    fenText.append(bord[row][col])
                } else {
                    fenText.append("/.")
                }
                
            }
        }
        return fenText
    }
    
    func stringToBord(fenText: String) {
        var n = 0
        let str = fenText
        for row in 0...7 {
            for col in 0...7 {
                if str[n ..< n + 2] == "/." {
                    bord[row][col] = ""
                }else{
                    bord[row][col] = str[n ..< n + 2]
                }
               n = n + 2
            }
        }
    }
    
    
    func getPlayerToGo() -> String {
        return playerToGo
    }
    
    func changePlayerToGo()  {
        if playerToGo == "Light" {
            playerToGo = "Dark"
        } else {
            playerToGo = "Light"
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
    func checkSchackMate() {
        let rule = Rules()
        if rule.SchackMate(bord: bord, enPassant: enPassant, player: playerToGo){
            if playerToGo == "Light" {
                schachMate[0] = true
            }else{
                schachMate[1] = true
            }
        }
    }
    
    func checkStaleMate() {
        let rule = Rules()
        if rule.StaleMate(bord: bord, enPassant: enPassant, player: playerToGo){
            if playerToGo == "Light" {
                staleMate[0] = true
            }else{
                staleMate[1] = true
            }
        }
    }
    
    func checkSchach()  {
        let rule = Rules()
        if rule.checkForSchach(bord: bord, player: playerToGo){
            if playerToGo == "Light" {
                schach[0] = true
            }else{
                schach[1] = true
            }
        }else{
            if playerToGo == "Light" {
                schach[0] = false
            }else{
                schach[1] = false
            }
        }
    }
    
    func goToNextPlayer() {
        changePlayerToGo()
        recetActivityBord()
        checkSchach()
        checkStaleMate()
        checkSchackMate()
        histBord[6] = histBord[5]
        histBord[5] = histBord[4]
        histBord[4] = histBord[3]
        histBord[3] = histBord[2]
        histBord[2] = histBord[1]
        histBord[1] = histBord[0]
        histBord[0] = bord
        if histBord[0] == histBord[4] && histBord[1] == histBord[5] && histBord[2] == histBord[6]{
            drawByRepitation = true
        }
    }
}
