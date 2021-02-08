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
   @State var move = 1
    var db = Firestore.firestore()
    @ObservedObject var bord = Bord()
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
                VStack{
                    Text("Multiplayer")
                    
                        
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: testFunc()).onAppear(){
                        listenToFireStore()
                    }

                    HStack{
                        Button(action: {
                            if bord.bord[3][3] == "" {
                                bord.bord[3][3] = bord.bord[1][3]
                                bord.bord[1][3] = ""
                            }else{
                                bord.bord[1][3] = bord.bord[3][3]
                                bord.bord[3][3] = ""
                             }
                        }) {
                            Image(systemName: "backward.fill")
                        }
                        .foregroundColor(.gray)
                        
                        Button(action: {
                            if bord.bord[4][3] == "" {
                                bord.bord[4][3] = bord.bord[6][3]
                                bord.bord[6][3] = ""
                            }else{
                                bord.bord[6][3] = bord.bord[4][3]
                                bord.bord[4][3] = ""
                             }
                        }) {
                            Image(systemName: "forward.fill")
                        }
                        
                        .foregroundColor(.gray)
                    }
                    // knappar och annat
                    Button(action: {
                        
                            db.collection("testItems2").addDocument(data: ["move": move, "state" : bord.bordToString()])
                        
                            
                            print("check")}, label: {
                        Image(systemName: "checkmark.square" )
                    })
//                    Button(action: {
//                            var tmp
//                            bord.bord = db.collection("testItems2")
//
//                            print("check")}, label: {
//                        Image(systemName: "checkmark.square" )
//                    })
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
    
    func testFunc(){
        print("func test 3")
    }
    
 func listenToFireStore() {
        
        db.collection("testItems2").addSnapshotListener{ (snapshot, err) in
            var tmpState = ""
            var tmpMove = 0
            for document in snapshot!.documents {
                if document["move"] as! Int > tmpMove {
                    tmpState = document["state"] as! String
                    tmpMove = document["move"] as! Int
                }
                    
               }
            move = tmpMove + 1
            print(tmpState)
            }
        }
}

struct  MultiPlayerGameView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPlayerGameView()
    }
}


