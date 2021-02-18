//
//  Bord.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

class Bord: ObservableObject {

    @Published var bord : [[String]]        // keep's track on current bord positions.
    @Published var activityBord : [[String]] // keep's track on which square is clicked and which squares are posible to move to.
    @Published var promotedPawn: [Int] = [-1, -1]   // -1 = no pawn to promote. else on which line the pawn sttands. first index for light, second for dark.
    @Published var promotePawn: Bool = false // indicates that there is a pawn to promote
    var playerToGo : String = "Light" // indicates which player to go. should be private
    @Published var schach : [Bool] = [false, false] //
    @Published var schachMate : [Bool] = [false, false]
    @Published var gameEnd: Bool = false
    @Published var schachMateEnd: Bool = false
    @Published var staleMate : [Bool] = [false, false]
    @Published var staleMateEnd : Bool = false
    @Published var kingHasMoved : [Bool] = [false, false]   // indicates i the king's has moved.
    var drawByRepitation : Bool = false   // returns true when the game has ended draw by repetation.
    var activeSquare: [Int]? = nil
    var activePice: String? = nil      // returns piece that is currently clicked
    var enPassant = [10, 10]        // 10 = no en passant move
    var histBord: [[[String]]] = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
    
    
    
    init() {

        bord = [["BR", "BN", "BB", "BQ", "BK", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
       
       
        
        activityBord = [["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",]]
        
        histBord[0] = bord
        
    }
    
    //  should containe all functions necessary resetGame
    func resetGame(){
                bord = [["BR", "BN", "BB", "BQ", "BK", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
                playerToGo = "Light"
                schach = [false, false]
                schachMate = [false, false]
                staleMate = [false, false]
                kingHasMoved  = [false, false]
                drawByRepitation  = false
                activeSquare = nil
                activePice = nil
                enPassant = [10, 10]        // 10 = no en passant move
                histBord = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
    }
    
    // transform a bord in form of [[String]] to a FEN "Forsyth-Edwards Notation"
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
    
    // transform a FEN "Forsyth-Edwards Notation" to a bord in form of [[String]]
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
    
    // geter for active player.
    func getPlayerToGo() -> String {
        return playerToGo
    }
    
    // change player.
    func changePlayerToGo()  {
        if playerToGo == "Light" {
            playerToGo = "Dark"
        } else {
            playerToGo = "Light"
        }
    }
    
    // reset ActivityBord.
    func recetActivityBord() {
        for row in 0...7 {
            for col in 0...7 {
                activityBord[row][col] = "none"
            }
        }

        activeSquare = nil
        activePice = nil
    }

    // while go through current bord and check for schack mate. And set gameEnd to true.
    func checkSchackMate() {
        let rule = Rules()
        if rule.SchackMate(bord: bord, enPassant: enPassant, player: playerToGo){
            if playerToGo == "Light" {
                schachMate[0] = true
            }else{
                schachMate[1] = true
            }
            gameEnd = true
        }
    }
    
    // while go through current bord and check for stale mate. And set gameEnd to true.
    func checkStaleMate() {
        let rule = Rules()
        if rule.StaleMate(bord: bord, enPassant: enPassant, player: playerToGo){
            if playerToGo == "Light" {
                staleMate[0] = true
            }else{
                staleMate[1] = true
            }
            gameEnd = true
        }
    }
    
    // while go through current bord and check for schack. and set schach white respective index to true.
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
    
    // Should run all functions necessary to move over to next player after one player have made a move.
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
            gameEnd = true
        }
    }
    
    // Takes a move from a PGN "Portable game notation" and updates bord.
    func pGNMoveToBord(pgn: String, player: String) {
        
        
        if player == "light" {
            switch pgn {
            case "0-0":
                bord[7][4] = ""
                bord[7][5] = "LR"
                bord[7][6] = "LK"
                bord[7][7] = ""
            case "0-0-0":
                bord[7][0] = ""
                bord[7][1] = ""
                bord[7][2] = "LK"
                bord[7][3] = "LR"
                bord[7][4] = ""
            default:
                bord[7][4] = ""

            }
        }
    }
    
}
