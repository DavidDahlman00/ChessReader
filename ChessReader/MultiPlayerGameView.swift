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
                    
                    
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: ["Multiplayer", gameNumber, color])
     

                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
}



