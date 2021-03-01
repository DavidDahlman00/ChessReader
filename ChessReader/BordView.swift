//
//  BordView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-03.
//

import Foundation
import SwiftUI
import Firebase

struct BordView: View {
   @ObservedObject var bord: Bord
    var db = Firestore.firestore()
    let imageSize: CGFloat
    var image: [[String]]
    let action: [Any]
    @State var str1: String = ""
    @State var str2: String = ""

    var schach: String{
        if (bord.playerToGo == "Light" && bord.staleMate[0]) || (bord.playerToGo == "Dark" && bord.staleMate[1]){
            return "StaleMate"
        }else
        if bord.drawByRepitation{
            return "drawByRepitation"
        }else if  (bord.playerToGo == "Light" && bord.schachMate[0]) || (bord.playerToGo == "Dark" && bord.schachMate[1]){
            return "SchackMate"
        }else if (bord.playerToGo == "Light" && bord.schach[0]) || (bord.playerToGo == "Dark" && bord.schach[1]){
            return "Schack"
        }else {
            return ""
        }
    }
    
   var schachMultiplayer: String{
        if bord.schach[0] || bord.schach[0] {
            return "schack"
        }
        return ""
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            Text(schach)
           
            
            RowView(bord: bord, imageSize: imageSize, row: 0, image: image[0], action: action)
            RowView(bord: bord, imageSize: imageSize, row: 1, image: image[1], action: action)
            RowView(bord: bord, imageSize: imageSize, row: 2, image: image[2], action: action)
            RowView(bord: bord, imageSize: imageSize, row: 3, image: image[3], action: action)
            RowView(bord: bord, imageSize: imageSize, row: 4, image: image[4], action: action)
            RowView(bord: bord, imageSize: imageSize, row: 5, image: image[5], action: action)
            RowView(bord: bord, imageSize: imageSize, row: 6, image: image[6], action: action)
            RowView(bord: bord, imageSize: imageSize, row: 7, image: image[7], action: action)
        }
        .padding()
        .onAppear(){
            if action[0] as! String == "Multiplayer" {
                listenToFireStore()
            
                
            }
        }

        .actionSheet(isPresented: $bord.promotePawn){
            ActionSheet(title: Text("Promote pawn to"), buttons: [
                            .default(Text("Queen")) { if bord.promotedPawn[0] != -1{
                                bord.bord[0][bord.promotedPawn[0]] = "LQ"
                            }else{
                                bord.bord[7][bord.promotedPawn[1]] = "BQ"
                            }
                            bord.promotePawn = false
                            bord.promotedPawn = [-1, -1]
                            bord.checkSchach()
                            },


                            .default(Text("Rook")) { if bord.promotedPawn[0] != -1{
                                bord.bord[0][bord.promotedPawn[0]] = "LR"
                            }else{
                                bord.bord[7][bord.promotedPawn[1]] = "BR"
                            }
                            bord.promotePawn = false
                            bord.promotedPawn = [-1, -1]
                            bord.checkSchach()
                            },


                            .default(Text("Knight")) { if bord.promotedPawn[0] != -1{
                                bord.bord[0][bord.promotedPawn[0]] = "LN"
                            }else{
                                bord.bord[7][bord.promotedPawn[1]] = "BN"
                            }
                            bord.promotePawn = false
                            bord.promotedPawn = [-1, -1]
                            bord.checkSchach()
                            },
                            .default(Text("Bishop")) { if bord.promotedPawn[0] != -1{
                                bord.bord[0][bord.promotedPawn[0]] = "LB"
                            }else{
                                bord.bord[7][bord.promotedPawn[1]] = "BB"
                            }
                            bord.promotePawn = false
                            bord.promotedPawn = [-1, -1]
                            bord.checkSchach()
                            },])
        }
    }
    
    func setSchack() -> String {
        if action[0] as! String != "Multiplayer2" {
            if (bord.playerToGo == "Light" && bord.staleMate[0]) || (bord.playerToGo == "Dark" && bord.staleMate[1]){
                return "StaleMate"
            }else
            if bord.drawByRepitation{
                return "drawByRepitation"
            }else if  (bord.playerToGo == "Light" && bord.schachMate[0]) || (bord.playerToGo == "Dark" && bord.schachMate[1]){
                return "SchackMate"
            }else if (bord.playerToGo == "Light" && bord.schach[0]) || (bord.playerToGo == "Dark" && bord.schach[1]){
                return "Schack"
            }else {
                return ""
            }
        }else{
            if (bord.playerToGo != "Light" && bord.staleMate[1]) || (bord.playerToGo == "Dark" && bord.staleMate[0]){
                return "StaleMate"
            }else
            if bord.drawByRepitation{
                return "drawByRepitation"
            }else if  (bord.playerToGo != "Light" && bord.schachMate[1]) || (bord.playerToGo == "Dark" && bord.schachMate[0]){
                return "SchackMate"
            }else if (bord.playerToGo != "Light" && bord.schach[1]) || (bord.playerToGo == "Dark" && bord.schach[0]){
                return "Schack"
            }else {
                return ""
            }
        }
    }
    
    func listenToFireStore() {
        let gameName = action[1] as! Int
       db.collection("multiplayerGames").document("games").collection("game\(gameName)").addSnapshotListener{ (snapshot, err) in
               var tmpState = ""
               var tmpMove = 0
               for document in snapshot!.documents {
                   if document["move"] as! Int > tmpMove {
                       tmpState = document["state"] as! String
                       tmpMove = document["move"] as! Int
                       bord.enPassant = document["enpassant"] as! [Int]
                       bord.playerToGo = document["playerToGo"] as! String
                       bord.schach = document["schack"] as! [Bool]
                       bord.multiplayerMoveCount = tmpMove
                   }
               }
               //move = tmpMove + 1
               if tmpState != "" {
                   bord.stringToBord(fenText: tmpState)
                  // bord.changePlayerToGo()
               }
               print(tmpState)
        bord.checkSchach()
        str1 = String(bord.schach[0])
        str2 = String(bord.schach[1])
           }
        
    
       }
}

struct RowView: View {
    @ObservedObject var bord: Bord
    let imageSize: CGFloat
    let row: Int
    let image: [String]
    let action: [Any]
    
    var body: some View {
        HStack(spacing: 0){
            SquareView(bord: bord, size: imageSize, action: action, pice: image[0], row: row, col: 0)
            SquareView(bord: bord, size: imageSize, action: action, pice: image[1], row: row, col: 1)
            SquareView(bord: bord, size: imageSize, action: action, pice: image[2], row: row, col: 2)
            SquareView(bord: bord, size: imageSize, action: action, pice: image[3], row: row, col: 3)
            SquareView(bord: bord, size: imageSize, action: action, pice: image[4], row: row, col: 4)
            SquareView(bord: bord, size: imageSize, action: action, pice: image[5], row: row, col: 5)
            SquareView(bord: bord, size: imageSize, action: action, pice: image[6], row: row, col: 6)
            SquareView(bord: bord, size: imageSize, action: action, pice: image[7], row: row, col: 7)

        }
    }
}

struct SquareView: View {
    @ObservedObject var bord: Bord
    var db = Firestore.firestore()
    var size: CGFloat
    var action: [Any]
    
    var color: Color{
        switch bord.activityBord[row][col] {
        case "none":
            if (row + col).isMultiple(of: 2) {
                return Color("LightSquareColor")
            }else{
                return Color("DarkSquareColor")
            }
        case "active":
            if (row + col).isMultiple(of: 2) {
                return Color("ActiveLightSquareColor")
            }else{
                return Color("ActiveDarkSquareColor")
            }
        case "inMoveList":
            if (row + col).isMultiple(of: 2) {
                return Color("MoveLightSquareColor")
            }else{
                return Color("MoveDarkSquareColor")
            }
        case "inEnPassantList":
            if (row + col).isMultiple(of: 2) {
                return Color("MoveLightSquareColor")
            }else{
                return Color("MoveDarkSquareColor")
            }
        case "casteling":
            if (row + col).isMultiple(of: 2) {
                return Color("MoveLightSquareColor")
            }else{
                return Color("MoveDarkSquareColor")
            }
        default:
            return Color(.purple)
        }
    }
    var pice: String
    let row: Int
    let col: Int
    
    func multiplayerActions() {

        if bord.playerToGo == action[2] as! String {
            let tmpBord = bord.bord
            bord.squareTuched(row: row, col: col)
            if tmpBord != bord.bord{
                let gameName = action[1] as! Int
                bord.multiplayerMoveCount = bord.multiplayerMoveCount + 1
                //bord.changePlayerToGo()
                bord.checkSchach()
                print("!!!!!!!!!!")
                print(bord.schach[0])
                print(bord.schach[1])
                db.collection("multiplayerGames").document("games").collection("game\(gameName)").addDocument(data: ["move": bord.multiplayerMoveCount, "state" : bord.bordToString(), "enpassant" : bord.enPassant, "playerToGo" : bord.playerToGo, "schack" : bord.schach])
                print(bord.playerToGo)
                
            }
        }
    }
    
    var body: some View {
        ZStack{
            if row == 0 {
                color
                    .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).mask(LinearGradient(gradient: Gradient(stops: [
                        .init(color: .clear, location: 0),
                        .init(color: color, location: 0.25)
                    ]), startPoint: .top, endPoint: .bottom))
            } else if row == 7 {
                color
                    .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).mask(LinearGradient(gradient: Gradient(stops: [
                        .init(color: color, location: 0.75),
                        .init(color: .clear, location: 1.0)
                    ]), startPoint: .top, endPoint: .bottom))
            }else {
            color
                .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Button(action: {
                switch action[0] as! String{
                //case "ChessBordView"      to be done
                case "SinglePlayerGameView":
                    print("test \(row), \(col)")
                    bord.squareTuched(row: row, col: col)
                    print(bord.activityBord[row][col])
                    //action
                case "Dark":
                    if bord.playerToGo == "Dark" {
                        bord.squareTuched(row: row, col: col)
                    }
                case "Light":
                    if bord.playerToGo == "Light" {
                        bord.squareTuched(row: row, col: col)
                    }
                case "Multiplayer":
                    multiplayerActions()
                case "ChessBordView": break
                    
                default:
                    print("test \(row), \(col)")
                    bord.squareTuched(row: row, col: col)
                    print(bord.activityBord[row][col])
                }
                
                
            }) {
                Image(bord.bord[row][col])
                    .resizable()
                    .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }.shadow(color: .gray, radius: 3.0, x: 0, y: 0)
    }
    

}
}
