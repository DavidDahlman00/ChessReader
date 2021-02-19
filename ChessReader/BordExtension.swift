import Foundation

extension Bord{
    func squareTuched(row: Int, col: Int)  {
        let pices = [["LB", "LK", "LN", "LP", "LR", "LQ"], ["DB", "DK", "DN", "DP", "DR", "DQ"]]
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
            if activePice == "DK" {
                kingHasMoved[1] = true
            }
            if activePice == "LP" && row == 0 {
                promotePawn = true
                promotedPawn = [col, -1]
            }
            if activePice == "DP" && row == 7 {
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
            if activePice == "DP" && row - activeSquare![0] == 2 {
                enPassant[1] = col
            }
            if playerToGo == "Light" {
                enPassant[1] = 10
            }else{
                enPassant[0] = 10
            }

            goToNextPlayer()
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
                bord[0][5] = "DR"
                bord[0][6] = "DK"
                bord[0][7] = ""
            } else if row == 0 && col == 2{
                bord[0][0] = ""
                bord[0][3] = "DR"
                bord[0][2] = "DK"
                bord[0][4] = ""
            }
            goToNextPlayer()
        case "none":
            if pices[player].contains(bord[row][col]){
                recetActivityBord()
                activityBord[row][col] = "active"
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
                            if rules.shortCastling(bord: self){
                                activityBord[7][6] = "casteling"
                                
                            }
                            if rules.longCastling(bord: self){
                                activityBord[7][2] = "casteling"
                               
                            }
                        }else{
                            moveList = rules.darkKing(bord: bord, checkSchack: true, row: row, col: col)
                            if rules.shortCastling(bord: self){
                                activityBord[0][6] = "casteling"
                                
                            }
                            if rules.longCastling(bord: self){
                                activityBord[0][2] = "casteling"
                               
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
                    }
            }
        default:
            recetActivityBord()
        }
    }
}
