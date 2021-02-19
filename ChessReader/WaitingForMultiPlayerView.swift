import Firebase
import SwiftUI

struct WaitingForMultiPlayerView: View {
    @State var showMultiplayerGame: Bool = false
    @ObservedObject var auth: GlobalAuth
    @State var email: String = ""
    @State var password: String = ""
    @State var gameNumber: Int = 0
    @State var color: String = "err"
    @State var waitingString = ""
    @State var waitingButton = "Start"
    var db = Firestore.firestore()
    
    var body: some View {
        NavigationView{
        ZStack{
            Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0).edgesIgnoringSafeArea(.all)

            VStack{
                
                Image("chessTest").resizable().scaledToFit()
                
                Button(action: {
                   
                }, label:{
                    Text("test")})
                HStack{
                }

                NavigationLink(
                    destination: MultiPlayerGameView(gameNumber: gameNumber, color: color ), isActive: $showMultiplayerGame){
                    Button(action: {
                        if color == "err"{
                            waitingString = "Waiting for oponent..."
                            waitingButton = "Wait."
                            db.collection("waitList").getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    
                                } else {
                                    for document in querySnapshot!.documents {
                                        gameNumber = document.data()["toGameCounter"] as! Int
                                        if document.data()["waiting"] as! Bool == false {
                                            color = "Dark"
                                            db.collection("waitList").document(document.documentID).delete()
                                            db.collection("waitList").addDocument(data: ["waiting": true, "toGameCounter": gameNumber])
                                        }else{
                                            color = "Light"
                                            db.collection("waitList").document(document.documentID).delete()
                                            db.collection("waitList").addDocument(data: ["waiting": false, "toGameCounter": gameNumber + 1])
                                            showMultiplayerGame = true
                                        }
                                    }
                                }
                            }
                        }
                        listenToFireStore()
                    }){
                    Text(waitingButton)
                        .font(.title)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .background(Color(red: 20.0/255.0, green: 20.0/255.0, blue: 48.0/255.0))
                        .cornerRadius(25)
                        .padding(20)
                        
                        
                }.background(Color(red: 20.0/255.0, green: 20.0/255.0, blue: 48.0/255.0))
                    .cornerRadius(25)
                    .padding(25)
            }
               
            }.edgesIgnoringSafeArea(.all)
            
            
        }
    }
      
   }
    func listenToFireStore() {
               db.collection("waitList").addSnapshotListener{ (snapshot, err) in
                if err != nil {
                    return
                }

                if !(snapshot?.isEmpty ?? true){

                    for document in snapshot!.documents {

                        if let inCounter = document["toGameCounter"] as? Int {

                        if inCounter > gameNumber && color != "err" {

                            showMultiplayerGame = true

                        }

                        } else{
                        
                        }
                       
                    }
                } else {
                    

                }
            }
        }
    }


