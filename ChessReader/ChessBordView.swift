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
    var game = ReadPGN()
    @State private var showingAlert = false
    @ObservedObject var bord = Bord()
    
    init() {
        game.readGame()
    }
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
                VStack{
                    // text och annat
                    Text(playedGame?.game ?? "Unknown Game")
                        .foregroundColor(.gray)
                        .bold()
                  
                    Button("Game Info") {
                               showingAlert = true
                           }
                           .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Game Info"), message: Text(game.information), dismissButton: .default(Text("Got it!")))
                           }
                       
                   
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: "ChessBordView")
                    HStack{
                        Button(action: {
                            game.moveBackward()
                            print(game.testPGN[game.testPGNInt])
                            
                        }) {
                            Image(systemName: "backward.fill")
                        }
                        .foregroundColor(.gray)
                        
                        Button(action: {
                            print(game.testPGNInt)
                            print(game.testPGN[game.testPGNInt])
                            bord.pGNMoveToBord(pgn: "0-0", player: "light")
                            print(game.information)
                            print(game.lightMoveList.count)
                            print(game.darkMoveList.count)
                            for move in game.lightMoveList{
                                print(move)
                            }
                            print("====================")
                            for move in game.darkMoveList{
                                print(move)
                            }
                            game.moveForward()
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
