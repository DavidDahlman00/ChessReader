//
//  Tmp3View.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-03.
//

import SwiftUI
import Firebase

struct  MultiPlayerGameView: View {
    //@State private var items = [Item]()
    let gameNumber: Int
    let color: String
    
   @State var move = 1
    var db = Firestore.firestore()
    @ObservedObject var bord = Bord()
    var playerToMove: String{
        if bord.playerToGo == color {
            return "Your turn to move"
        }else{
            return "Waiting for opponent"
        }
        
    }
   
   
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color("BackGroundColor")
                VStack{
                        
                    Text(playerToMove)
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)
                        .padding()
                    
                    Text("\(gameNumber)")
                     .font(.footnote)
                    
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: ["Multiplayer", gameNumber, color])
                        .onAppear(){
                       // listenToFireStore()
                    }

                    // knappar och annat
//                    if bord.playerToGo != color {
//                        Button(action: {
//                            db.collection("game\(gameNumber)").addDocument(data: ["move": move, "state" : bord.bordToString()])
//                            bord.changePlayerToGo()
//                            }, label: {
//                                Text("Commit move")
//                                    .gradientForeground(colors: [.blue, Color("TextColor2")])
//                            .font(.title)
//                            .padding()
//                                })
//                            }
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }

 func listenToFireStore() {
        
    db.collection("multiplayerGames").document("games").collection("game\(gameNumber)").addSnapshotListener{ (snapshot, err) in
            var tmpState = ""
            var tmpMove = 0
            for document in snapshot!.documents {
                if document["move"] as! Int > tmpMove {
                    tmpState = document["state"] as! String
                    tmpMove = document["move"] as! Int
                    bord.enPassant = document["enpassant"] as! [Int]
                    bord.playerToGo = document["playerToGo"] as! String
                }
            }
            move = tmpMove + 1
            if tmpState != "" {
                bord.stringToBord(fenText: tmpState)
               // bord.changePlayerToGo()
            }
            print(tmpState)
        }
    }

}



