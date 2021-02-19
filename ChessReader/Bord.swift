import Foundation

class Bord: ObservableObject {

    @Published var bord : [[String]]
    @Published var activityBord : [[String]]
    @Published var promotedPawn: [Int] = [-1, -1]   // -1 = no pawn to promote
    @Published var promotePawn: Bool = false
    var playerToGo : String = "Light"
    @Published var schach : [Bool] = [false, false]
    @Published var schachMate : [Bool] = [false, false]
    @Published var gameEnd: Bool = false
    @Published var schachMateEnd: Bool = false
    @Published var staleMate : [Bool] = [false, false]
    @Published var staleMateEnd : Bool = false
    @Published var kingHasMoved : [Bool] = [false, false]
    var drawByRepitation : Bool = false
    var activeSquare: [Int]? = nil
    var activePice: String? = nil
    var enPassant = [10, 10]        // 10 = no en passant move
    var histBord: [[[String]]] = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
    
    
    
    init() {

        bord = [["DR", "DN", "DB", "DQ", "DK", "DB", "DN", "DR"], ["DP","DP","DP","DP","DP","DP","DP","DP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
       
       
        
        activityBord = [["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",], ["none", "none", "none", "none", "none", "none", "none", "none",]]
        
        histBord[0] = bord
        
    }
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
            gameEnd = true
        }
    }
    
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
