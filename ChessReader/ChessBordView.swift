//
//  ChessBordView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-27.
//

import SwiftUI
import Firebase

struct ChessBordView : View {
    var playedGame : GameListEntry? = nil
    var testText: String = "Test"
    @State var color = "light"
    @State var lightCount = 0
    @State var darkCount = 0
    @State var lightTestString = ""
    @State var darkTestString = ""
    var game = ReadPGN()
    var db = Firestore.firestore()
    @State private var showingAlert = false
    @ObservedObject var bord = Bord()
    
    init() {
        game.readGame()
        bord.pgnBordHist.append(bord.bord)
    }
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color("BackGroundColor")
                VStack{
                    // text och annat
                    Text(playedGame?.game ?? "Unknown Game")
                        .bold()
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)
                        .padding(.bottom)
                

                    HStack{
                        Text(lightTestString)
                            .font(.footnote)
                        Text(darkTestString)
                            .font(.footnote)
                    }
                    
                   
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: "ChessBordView")
                    HStack{
                        Button(action: {
                            if bord.pgnBordHist.count > 1{
                                bord.pgnBordHist.remove(at: bord.pgnBordHist.count - 1)
                                bord.bord = bord.pgnBordHist[bord.pgnBordHist.count - 1]
                                if color == "light"{
                                    darkCount = darkCount - 1
                                    color = "dark"
                                }else {
                                    lightCount = lightCount - 1
                                    color = "light"
                                }
                            }
                            
                        }) {
                            Image(systemName: "backward.fill")
                        }
                        
                        Button(action: {
                            if color == "light" {
                                if lightCount < game.lightMoveList.count{
                                    print(game.lightMoveList[lightCount])
                                    print(lightCount)
                                    bord.pGNMoveToBord(pgn: game.lightMoveList[lightCount], player: "light")
                                    bord.pgnBordHist.append(bord.bord)
                                    lightTestString = "\(lightCount + 1): \(color):  \(game.lightMoveList[lightCount])"
                                    lightCount = lightCount + 1
                                    color = "dark"
                                }
                            }else {
                                if darkCount < game.darkMoveList.count{
                                    print(game.darkMoveList[darkCount])
                                    print(darkCount)
                                    bord.pGNMoveToBord(pgn: game.darkMoveList[darkCount], player: "dark")
                                    bord.pgnBordHist.append(bord.bord)
                                    darkTestString = "\(darkCount + 1): \(color):  \(game.darkMoveList[darkCount])"
                                    darkCount = darkCount + 1
                                    color = "light"
                                }
                            }
                        }) {
                            Image(systemName: "forward.fill")
                        }
                    }.padding(.bottom)
                    
                    Text(playedGame?.coment ?? "Nobody coment this game, yet")
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.footnote)
                        .padding()
                   
                    Button("Game Info") {
                               showingAlert = true
                           }
                           .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Game Info"), message: Text(game.information), dismissButton: .default(Text("Got it!")))
                           }
                    
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
