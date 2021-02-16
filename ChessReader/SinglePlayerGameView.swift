//
//  Tmp2View.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-03.
//
import SwiftUI
import Firebase

struct SinglePlayerGameView: View {
    var db = Firestore.firestore()
    @State private var showingSheet = false
    @ObservedObject var bord = Bord()
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
                VStack{
                
                    Text("\(bord.getPlayerToGo())'s turn to move")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: "SinglePlayerGameView")
                    Button(action: {
                        
                            db.collection("testItems1").addDocument(data: ["state" : bord.bordToString()])
                        
                            
                            print("check")}, label: {
                                Image(systemName: "checkmark.square" ).resizable()
                                    .aspectRatio(contentMode:.fit).frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })

                    Button(action: {
                     
                        self.showingSheet = true
                    }) {
                        Text("Reset").font(.system(size: 20))
                    }
                    .foregroundColor(.gray)
                    .actionSheet(isPresented: $showingSheet){
                        ActionSheet(title: Text("Would you like to restart?"), buttons: [.default(Text("Yes")){
                            
                            bord.bord = [["BR", "BN", "BB", "BQ", "BK", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
                            bord.playerToGo = "Light"
                            bord.schach = [false, false]
                            bord.schachMate = [false, false]
                            bord.staleMate = [false, false]
                            bord.kingHasMoved  = [false, false]
                            bord.drawByRepitation  = false
                            bord.activeSquare = nil
                            bord.activePice = nil
                            bord.enPassant = [10, 10]        // 10 = no en passant move
                            bord.histBord = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
                           
                        }, .cancel()])
                    }
                }.alert(isPresented: $bord.gameEnd){
                    Alert(title: Text("White won"),
                          message: Text("Would you like to reset?"),
                          primaryButton: .destructive(Text("Reset")){
                            bord.bord = [["BR", "BN", "BB", "BQ", "BK", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["LP","LP","LP","LP","LP","LP","LP","LP"], ["LR", "LN", "LB", "LQ", "LK", "LB", "LN", "LR"]]
                            bord.playerToGo = "Light"
                            bord.schach = [false, false]
                            bord.schachMate = [false, false]
                            bord.staleMate = [false, false]
                            bord.kingHasMoved  = [false, false]
                            bord.drawByRepitation  = false
                            bord.activeSquare = nil
                            bord.activePice = nil
                            bord.enPassant = [10, 10]        // 10 = no en passant move
                            bord.histBord = [[["a"]], [["b"]], [["c"]], [["d"]], [["e"]], [["f"]],[["g"]]]
                          },
                          secondaryButton: .default(Text("View Game!")){
                            
                          })
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
