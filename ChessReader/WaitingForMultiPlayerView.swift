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
            Color("BackGroundColor").edgesIgnoringSafeArea(.all)

            VStack{
                Text(waitingString).font(.system(size: 30))
                    .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                    .font(.title)
                Image("chessTest").resizable().scaledToFit()
            
                HStack{

                }

                NavigationLink(
                    destination: MultiPlayerGameView(gameNumber: gameNumber, color: color ), isActive: $showMultiplayerGame){
                    Button(action: {
                        if color == "err"{
                            waitingString = "Waiting for oponent..."
                            waitingButton = ""
                            db.collection("waitList").getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    print("Error getting documents: \(err)")
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
                        .fontWeight(.bold)

                        .padding(30)
                        
                        
                }
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

                            print("Yessss")

                            showMultiplayerGame = true

                        }

                        } else{
                            print("Error inCounter nil")
                        }
                        print(gameNumber)
                        print(color)
                      //  print(document.data()["toGameCounter"] )
                    }
                } else {
                    print("snapshot did not work")

                }
            }
        }
    }


