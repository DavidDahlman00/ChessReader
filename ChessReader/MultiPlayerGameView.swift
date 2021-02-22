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
                    Text(color)
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)
                    Text("\(gameNumber)")
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)
                    Text("Multiplayer")
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)
                        
                    Text(playerToMove)
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)
                       
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: color).onAppear(){
                        listenToFireStore()
                    }

                    // knappar och annat
                    Button(action: {
                        
                            db.collection("game\(gameNumber)").addDocument(data: ["move": move, "state" : bord.bordToString()])
                            bord.changePlayerToGo()
                            
                            print("check")}, label: {
                        Image(systemName: "checkmark.square" )
                    })
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
    
    func testFunc(){
        print("func test 3")
    }
    
 func listenToFireStore() {
        
        db.collection("game\(gameNumber)").addSnapshotListener{ (snapshot, err) in
            var tmpState = ""
            var tmpMove = 0
            for document in snapshot!.documents {
                if document["move"] as! Int > tmpMove {
                    tmpState = document["state"] as! String
                    tmpMove = document["move"] as! Int
                }
                    
               }
            move = tmpMove + 1
            if tmpState != "" {
                bord.stringToBord(fenText: tmpState)
                bord.changePlayerToGo()
            }
            
            print(tmpState)
            }
        }
}



