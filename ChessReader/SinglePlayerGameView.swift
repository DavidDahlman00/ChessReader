//
//  Tmp2View.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-03.
//
import SwiftUI
import Firebase

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .top,
                                    endPoint: .bottom))
            .mask(self)
    }
}

struct SinglePlayerGameView: View {
    var db = Firestore.firestore()
    @State private var showingSheet = false
    @ObservedObject var bord = Bord()
    
    var tempOcation = "SovietChamp1972"
    var tempPlayers = "Razuvaev, Yuri S - Zhidkov, Valery S"
    var tempGame = """

[Event "URS-ch40"]
[Site "Baku"]
[Date "1972.??.??"]
[Round "?"]
[White "Razuvaev, Yuri S"]
[Black "Zhidkov, Valery S"]
[Result "1/2-1/2"]
[WhiteElo "2490"]
[BlackElo "2490"]
[ECO "E04"]

1.d4 Nf6 2.c4 e6 3.g3 d5 4.Nf3 dxc4 5.Bg2 a6 6.a4 Bd7 7.Nbd2 Bb4 8.Qc2 Bc6
9.Qxc4 a5 10.O-O Nbd7 11.Qd3 O-O 12.b3 Re8 13.Bb2 Bxd2 14.Qxd2  1/2-1/2

"""
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color("BackGroundColor")
                VStack{
                
                    Text("\(bord.getPlayerToGo())'s turn to move")
                        .font(.largeTitle)
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)

                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: "SinglePlayerGameView")
                    
                    Button(action: {

                            db.collection("gameList").addDocument(data: ["ocation" : tempOcation, "players" : tempPlayers, "game" : tempGame])


                            print("check")}, label: {
                                Image(systemName: "checkmark.square" ).resizable()
                                    .aspectRatio(contentMode:.fit).frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })

                    Button(action: {
                     
                        self.showingSheet = true
                    }) {
                        Text("Reset")
                            .gradientForeground(colors: [.blue, Color("TextColor2")])
                            .font(.title)
                    }
                    
                    .actionSheet(isPresented: $showingSheet){
                        ActionSheet(title: Text("Would you like to restart?"), buttons: [.default(Text("Yes")){
                            
                            bord.resetGame()
                           
                        }, .cancel()])
                    }
                }.alert(isPresented: $bord.gameEnd){
                    if bord.schachMate[1]{
                        return Alert(title: Text("White won"),
                                     message: Text("Would you like to reset?"),
                                     primaryButton: .destructive(Text("Reset")){
                                       bord.resetGame()
                                     },
                                     secondaryButton: .default(Text("View Game!")){
                                       
                                     })
                    } else  if bord.schachMate[0]{
                        return Alert(title: Text("Black won"),
                                     message: Text("Would you like to reset?"),
                                     primaryButton: .destructive(Text("Reset")){
                                       bord.resetGame()
                                     },
                                     secondaryButton: .default(Text("View Game!")){
                                       
                                     })
                    } else if bord.staleMateEnd{
                        return Alert(title: Text("StaleMate"),
                                     message: Text("Would you like to reset?"),
                                     primaryButton: .destructive(Text("Reset")){
                                       bord.resetGame()
                                     },
                                     secondaryButton: .default(Text("View Game!")){
                                       
                                     })
                    }else{
                        return Alert(title: Text("Draw by repetition"),
                                     message: Text("Would you like to reset?"),
                                     primaryButton: .destructive(Text("Reset")){
                                       bord.resetGame()
                                     },
                                     secondaryButton: .default(Text("View Game!")){
                                       
                                     })
                    }
                    
                }
                
                
                
                
            }.edgesIgnoringSafeArea(.all)
            
            
        }
    }
}

struct SinglePlayerGameView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerGameView()
    }
}
