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
