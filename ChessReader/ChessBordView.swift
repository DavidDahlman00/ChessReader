import SwiftUI
import Firebase

struct ChessBordView : View {
    var playedGame : GameListEntry
    var testText: String = "Test"
    @State var color = "light"
    @State var lightCount = 0
    @State var darkCount = 0
    var lightTestString : String{
        if lightCount == 0 {
            return ""
        }else{
            return "Light's \(lightCount) move: \(game.lightMoveList[lightCount - 1])"
        }
    }
    var darkTestString : String{
        if darkCount == 0 {
            return ""
        }else{
            return "Dark's \(darkCount) move:  \(game.darkMoveList[darkCount - 1])"
        }
    }
    var game : ReadPGN
    var db = Firestore.firestore()
    @State private var showingAlert = false
    @State private var showingSheet = false
    @ObservedObject var bord = Bord()
    @State private var gameComment = ""
    @State private var showDialog = false
    @State private var showComment = false
    
    init(playedGame: GameListEntry) {

        self.playedGame = playedGame
        game = ReadPGN(testPGN: playedGame.game)
        bord.pgnBordHist.append(bord.bord)

    }
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color("BackGroundColor")
                VStack{

                    Text(playedGame.ocation ?? "Unknown Event")
                        .bold()
                        .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                        .font(.title)
               
                    Text(playedGame.players ?? "?? - ??")
                        .bold()
                        .foregroundColor(.gray)

                        .font(.subheadline)
                        //.padding(.bottom)
                    
                  
                        
                

                    HStack{
                        Text(lightTestString)
                            .font(.footnote)
                        Text(darkTestString)
                            .font(.footnote)
                    }
                    

                
                   
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord, action: ["ChessBordView"])
//                        .alert(isPresented: $showingWinnerAlert) {
//                        Alert(title: Text("Winner"), message: Text(game.winner), dismissButton: .default(Text("Got it!")))
//                       }
                        .alert(isPresented: $showingSheet){
                            Alert(title: Text("Winner"),
                                  message: Text(game.winner),
                                  primaryButton: .destructive(Text("Reset")){
                                   resetGame()
                                    showingSheet = false
                                  },
                                  secondaryButton: .default(Text("View Game!")){
                                    showingSheet = false
                                  })
                        }
                        .alert(isPresented: $showComment) {
                         if lightCount > darkCount {
                             return  Alert(title: Text("Comment"), message: Text(game.lighCommentList[lightCount - 1]), dismissButton: .default(Text("Got it!")))
                         }else{
                             return  Alert(title: Text("Comment"), message: Text(game.darkCommentList[darkCount - 1]), dismissButton: .default(Text("Got it!")))
                         }
                        
                        }
                    HStack{
                        
                       
                            
                        
                        
                        HStack(alignment: .center){
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
                                    .gradientForeground(colors: [.blue, Color("TextColor2")])
                                    .font(.title)
                            }
                            
                            Button(action: {
                                
                                if color == "light" {
                                    if lightCount < game.lightMoveList.count{
                                       
                                        bord.pGNMoveToBord(pgn: game.lightMoveList[lightCount], player: "light")
                                        bord.pgnBordHist.append(bord.bord)
                                        lightCount = lightCount + 1
                                        color = "dark"
                                    }else{
                                        showingSheet = true
                                    }
                                }else if darkCount < game.darkMoveList.count{
                                       
                                        bord.pGNMoveToBord(pgn: game.darkMoveList[darkCount], player: "dark")
                                        bord.pgnBordHist.append(bord.bord)
                                        darkCount = darkCount + 1
                                        color = "light"
                                }else{
                                    self.showingSheet = true
                                }
                                
                            }) {
                                Image(systemName: "forward.fill")
                                    .gradientForeground(colors: [.blue, Color("TextColor2")])
                                    .font(.title)
                            }
                        }
                        
                    }.padding(.bottom)
                    
                    
      

                    
                    // knappar och annat
                    HStack{
                        Button(action: {
                            self.showingAlert = true
                        }) {
                            Text("Game Info")
                                .gradientForeground(colors: [Color("TextColor2"), .blue])
                                .font(.title)
                               }
                        .alert(isPresented: $showingAlert) {
                         Alert(title: Text("Game Info"), message: Text(game.information), dismissButton: .default(Text("Got it!")))
                        }
                        
                        HStack{
                            if lightCount > 0 {
                                Button(action: {showDialog = true
                                    
                                }){
                                    Image(systemName: "pencil")
                                        .gradientForeground(colors: [.blue, Color("TextColor2")])
                                        .font(.title)
                                }
                                
                            }
                        }
                        
                        HStack{
                            if lightCount > darkCount {
                                if lightCount > 0 && game.lighCommentList[lightCount - 1] != "" {
                                    Button(action: {showComment = true
                                        
                                    }){
                                        Image(systemName: "eye")
                                            .gradientForeground(colors: [.blue, Color("TextColor2")])
                                            .font(.title)
                                    }
                                                               }
                            }else if darkCount > 0 && game.darkCommentList[darkCount - 1] != "" {
                                Button(action: {showComment = true
                                    
                                }){
                                    Image(systemName: "eye")
                                        .gradientForeground(colors: [.blue, Color("TextColor2")])
                                        .font(.title)
                                }
                                
                            }
                        }
                    }
                   
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }  .alert(isPresented: $showDialog,
                  TextAlert(title: "Title",
                                message: "Message",
                                keyboardType: .default) { result in
                    if let text = result {
                        if lightCount > darkCount {
                            if lightCount > 0 {
                          game.lighCommentList[lightCount - 1] = text
                                print(game.lighCommentList[lightCount])
                            }
                        }else{
                            if darkCount > 0 {
                          game.darkCommentList[darkCount - 1] = text
                                print(game.darkCommentList[darkCount])
                            }
                        }
                       
                    } else {
                      // The dialog was cancelled
                    }
                  }
     ).onAppear(){
            game.readGame()
        }
    }
    
    func resetGame() {
        lightCount = 0
        darkCount = 0
        color = "light"
        let tmp = bord.pgnBordHist[0]
        bord.pgnBordHist = [tmp]
        bord.bord = tmp
    }
    
}

struct ChessBordView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
