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
    var tempPlayers = "Mukhin, Mikhail A - Razuvaev, Yuri S"
    var tempGame = """

[Event "URS-ch40"]
[Site "Baku"]
[Date "1972.??.??"]
[Round "?"]
[White "Mukhin, Mikhail A"]
[Black "Kholmov, Ratmir D"]
[Result "1/2-1/2"]
[WhiteElo "2420"]
[BlackElo "2550"]
[ECO "E55"]

1.d4 Nf6 2.c4 e6 3.Nc3 Bb4 4.e3 c5 5.Bd3 d5 6.Nf3 dxc4 7.Bxc4 O-O 8.O-O Nbd7
9.Qe2 b6 10.Rd1 cxd4 11.exd4 Bb7 12.Bg5 Bxc3 13.bxc3 Qc7 14.Nd2 Rfe8 15.Rac1 e5
16.Qd3 h6 17.Bh4 Rac8 18.Bg3 Qd8 19.Re1 exd4 20.cxd4 Rxe1+ 21.Rxe1 Nf8 22.h3 Ng6
23.Bb3 Bd5 24.Nc4 Qd7 25.Nd6 Rd8 26.Bxd5 Nxd5 27.Qf3 Nf6 28.Nf5 Nd5 29.Nd6 Nf6
30.Nf5 Nd5  1/2-1/2

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
