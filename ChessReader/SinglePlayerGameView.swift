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
    
    var tempOcation = "Stavanger 2020"
    var tempPlayers = "Caruana,F - Tari,A"
    var tempGame = """

[Event "8th Norway Armageddon"]
[Site "Stavanger NOR"]
[Date "2020.10.16"]
[Round "10.3"]
[White "Caruana,F"]
[Black "Tari,A"]
[Result "1-0"]
[WhiteTitle "GM"]
[BlackTitle "GM"]
[WhiteElo "2828"]
[BlackElo "2633"]
[ECO "C84"]
[Opening "Ruy Lopez"]
[Variation "closed defence"]
[WhiteFideId "2020009"]
[BlackFideId "1510045"]
[EventDate "2020.10.05"]

1. e4 e5 2. Nf3 Nc6 3. Bb5 a6 4. Ba4 Nf6 5. O-O Be7 6. d3 b5 7. Bb3 d6 8. Bd2
O-O 9. h3 Rb8 10. Re1 h6 11. a3 Re8 12. Nc3 Bf8 13. Ne2 Be6 14. Ng3 d5 15. Qe2
dxe4 16. dxe4 Bxb3 17. cxb3 Nd4 18. Nxd4 exd4 19. b4 Nd7 20. Bf4 Rc8 21. Rad1 c5
22. bxc5 Nxc5 23. Qg4 Kh8 24. e5 Ne6 25. Nf5 Rc2 26. Nd6 Bxd6 27. exd6 Qf6 28.
Bg3 Rd8 29. Bh4 g5 30. Bg3 Kh7 31. Qe4+ Qg6 32. Qb7 Rxb2 33. Qe7 Rg8 34. d7 Qh5
35. Rxe6 Qxd1+ 36. Kh2 Rb1 37. Qxf7+ Rg7 38. Qf5+ 1-0

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
