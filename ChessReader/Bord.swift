import Foundation
import Firebase

class Bord: ObservableObject {
    var db = Firestore.firestore()
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
    @Published var pgnBordHist : [[[String]]] = [[[String]]]()
    var drawByRepitation : Bool = false   // returns true when the game has ended draw by repetation.
    var activeSquare: [Int]? = nil
    var activePice: String? = nil      // returns piece that is currently clicked
    var enPassant = [10, 10]        // 10 = no en passant move
    var histBord: [[[String]]] = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
    
    
    
    init() {

        bord = [["DR", "DN", "DB", "DQ", "DK", "DB", "DN", "DR"], ["DP","DP","DP","DP","DP","DP","DP","DP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
       
        
        activityBord = [["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",]]
        
        histBord[0] = bord
        
    }
    
    //  should containe all functions necessary resetGame
    func resetGame(){
                bord = [["DR", "DN", "DB", "DQ", "DK", "DB", "DN", "DR"], ["DP","DP","DP","DP","DP","DP","DP","DP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
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
        var piece: String = ""
        var toCol: Int = -1
        var toRow: Int = -1
        var fromRow: Int = -1
        var fromCol: Int = -1
        var schacked: Bool{
           return ["+"].contains(pgn)
        }
        var _ = false
        
        if !["0-0", "0-0-0"].contains(pgn){
            if pgn.contains("B") {
                piece = "B"
            }else if pgn.contains("K") {
                piece = "K"
            }else if pgn.contains("N") {
                piece = "N"
            }else if pgn.contains("Q") {
                piece = "Q"
            }else if pgn.contains("R") {
                piece = "R"
            }else{
                piece = "P"
            }
            let move = pgn.filter{
                ["a", "b", "c", "d", "e", "f", "g", "h", "1", "2", "3", "4", "5", "6", "7", "8"].contains($0)}
                if move.count == 2{
                    let col = move[0]
                    let row = Int(move[1]) ?? -1
                    toRow = 8 - row
                    switch col {
                    case "a":
                        toCol = 0
                    case "b":
                        toCol = 1
                    case "c":
                        toCol = 2
                    case "d":
                        toCol = 3
                    case "e":
                        toCol = 4
                    case "f":
                        toCol = 5
                    case "g":
                        toCol = 6
                    case "h":
                        toCol = 7
                    default:
                        _ = true
                    }
                }else{
                    let colums = move.filter{
                        ["a", "b", "c", "d", "e", "f", "g", "h"].contains($0)}
                    let rows = move.filter{
                        [ "1", "2", "3", "4", "5", "6", "7", "8"].contains($0)}
                    if rows.count == 2 {
                        let row = Int(rows[0]) ?? -1
                        fromRow = 8 - row
                    }
                    if colums.count == 2 {
                        let col = colums[0]
                        switch col {
                        case "a":
                            fromCol = 0
                        case "b":
                            fromCol = 1
                        case "c":
                            fromCol = 2
                        case "d":
                            fromCol = 3
                        case "e":
                            fromCol = 4
                        case "f":
                            fromCol = 5
                        case "g":
                            fromCol = 6
                        case "h":
                            fromCol = 7
                        default:
                            _ = true
                        }
                    }
                }
            
        }
        
        if player == "light" {
            switch pgn {
            case "O-O":
                bord[7][4] = ""
                bord[7][5] = "LR"
                bord[7][6] = "LK"
                bord[7][7] = ""
            case "O-O-O":
                bord[7][0] = ""
                bord[7][1] = ""
                bord[7][2] = "LK"
                bord[7][3] = "LR"
                bord[7][4] = ""
            default:
                var pieceWithColor = "L" + piece
                pGNMove(piece: pieceWithColor, fromRow: fromRow, fromCol: fromCol, toRow: toRow, toCol: toCol, schacked: schacked)
            }
        }else{
            switch pgn {
            case "O-O":
                bord[0][4] = ""
                bord[0][5] = "BR"
                bord[0][6] = "BK"
                bord[0][7] = ""
            case "O-O-O":
                bord[0][0] = ""
                bord[0][1] = ""
                bord[0][2] = "BK"
                bord[0][3] = "BR"
                bord[0][4] = ""
            default:
                var pieceWithColor = "B" + piece
                pGNMove(piece: pieceWithColor, fromRow: fromRow, fromCol: fromCol, toRow: toRow, toCol: toCol, schacked: schacked)
            }
        }
    }
    
    func pGNMove(piece: String, fromRow: Int, fromCol: Int, toRow: Int, toCol: Int, schacked: Bool) {
        let getFrom = getPositionsOfPieces(piece: piece)
        if getFrom.count == 1 {
            let from = getFrom[0]
            bord[from[0]][from[1]] = ""
            bord[toRow][toCol] = piece
        }else{
            let rules = Rules()
            for pos in getFrom {
                var row: Int{
                    if fromRow != -1 {
                        return fromRow
                    }else{
                        return pos[0]
                    }
                }
                var col: Int{
                    if fromCol != -1 {
                        return fromCol
                    }else{
                        return pos[1]
                    }
                }
                var posibleMove: Bool = false
                switch piece {
                case "LB":
                    posibleMove = rules.lightBishop(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "BB":
                    posibleMove = rules.darkBishop(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "LK":
                    posibleMove = rules.lightKing(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "BK":
                    posibleMove = rules.darkBishop(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "LN":
                    posibleMove = rules.lightKnight(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "BN":
                    posibleMove = rules.darkKnight(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "LP":
                    posibleMove = rules.lightPawn(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "BP":
                    posibleMove = rules.darkPawn(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "LQ":
                    posibleMove = rules.lightQueen(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "BQ":
                    posibleMove = rules.darkQueen(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "LR":
                    posibleMove = rules.lightRook(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                case "BR":
                    posibleMove = rules.darkRook(bord: bord, checkSchack: schacked, row: row, col: col).contains([toRow, toCol])
                default:
                    var _ = true
                }
                if pos[0] == row && pos[1] == col && posibleMove{
                    bord[row][col] = ""
                    bord[toRow][toCol] = piece
                }
            }
        }
    }
    
    func getPositionsOfPieces(piece: String) -> [[Int]] {
        var moveList = [[Int]]()
        for row in 0...7{
            for col in 0...7{
                if bord[row][col] == piece {
                    moveList.append([row, col])
                }
            }
        }
        return moveList
    }
    
    func getPositionsOfPiecesKnownRow(piece: String, row: Int) -> [[Int]] {
        var moveList = [[Int]]()
            for col in 0...7{
                if bord[row][col] == piece {
                    moveList.append([row, col])
                }
        }
        return moveList
    }
    
    func getPositionsOfPiecesKnownCol(piece: String, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        for row in 0...7{
                if bord[row][col] == piece {
                    moveList.append([row, col])
            }
        }
        return moveList
    }
    
    func sendToDBMultiplayer(game: Int, move: Int){
        db.collection("game\(game)").addDocument(data: ["move": move, "state" : bordToString()])
       changePlayerToGo()
    }
    
}
