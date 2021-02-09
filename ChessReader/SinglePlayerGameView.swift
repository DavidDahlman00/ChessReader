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
                    
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: testFunc())
                    Button(action: {
                        
                            db.collection("testItems1").addDocument(data: ["state" : bord.bordToString()])
                        
                            
                            print("check")}, label: {
                        Image(systemName: "checkmark.square" )
                    })
//                    HStack{
//                        Button(action: {
//                            if bord.bord[3][3] == "" {
//                                bord.bord[3][3] = bord.bord[1][3]
//                                bord.bord[1][3] = ""
//                            }else{
//                                bord.bord[1][3] = bord.bord[3][3]
//                                bord.bord[3][3] = ""
//                             }
//                        }) {
//                            Image(systemName: "backward.fill")
//                        }
//                        .foregroundColor(.gray)
//
//                        Button(action: {
//                            if bord.bord[4][3] == "" {
//                                bord.bord[4][3] = bord.bord[6][3]
//                                bord.bord[6][3] = ""
//                            }else{
//                                bord.bord[6][3] = bord.bord[4][3]
//                                bord.bord[4][3] = ""
//                             }
//                        }) {
//                            Image(systemName: "forward.fill")
//                        }
//
//                        .foregroundColor(.gray)
//                    }
                    // knappar och annat
                    
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
                        }, .cancel()])
                    }
                }
                
                
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
    func testFunc(){
        print("func test 2")
    }
}

struct SinglePlayerGameView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerGameView()
    }
}
