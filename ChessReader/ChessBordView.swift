//
//  ChessBordView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-27.
//

import SwiftUI

struct ChessBordView : View {
    var playedGame : GameListEntry? = nil
    var testText: String = "Test"

    
   @ObservedObject var bord = Bord()
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
                VStack{
                    // text och annat
                    Text(playedGame?.game ?? "Unknown Game")
                        .foregroundColor(.gray)
                        .bold()
                        
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: "ChessBordView")
                    HStack{
                        Button(action: {
                            if bord.testPGNInt > 0 {
                                bord.testPGNInt = bord.testPGNInt - 1
                                print("move back")
                                print(bord.testPGN[bord.testPGNInt])
                            }
                        }) {
                            Image(systemName: "backward.fill")
                        }
                        .foregroundColor(.gray)
                        
                        Button(action: {
                            if bord.testPGNInt < bord.testPGN.count - 1{
                                bord.testPGNInt = bord.testPGNInt + 1
                                print("move forward")
                                print(bord.testPGN[bord.testPGNInt])
                             }
                        }) {
                            Image(systemName: "forward.fill")
                        }
                        
                        .foregroundColor(.gray)
                    }
                    
                    Text(playedGame?.coment ?? "Nobody coment this game, yet")
                        .foregroundColor(.gray)
                        .bold()
                    
                    
                    // knappar och annat
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }

    func testFunc(){
        print("func test 1 ")
    }
    
}

struct ChessBordView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
