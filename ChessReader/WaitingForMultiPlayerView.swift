
import Firebase
import SwiftUI

struct WaitingForMultiPlayerView: View {
    @State var showMultiplayerGame: Bool = false
    @ObservedObject var auth: GlobalAuth
    @State var email: String = ""
    @State var password: String = ""
    @State var gameNumber: Int = 0
    @State var color: String = "err"
    var db = Firestore.firestore()
    
    var body: some View {
        NavigationView{
        ZStack{
            Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0).edgesIgnoringSafeArea(.all)
            //Image("chessTest").resizable().scaledToFit()
            VStack{
                Image("chessTest").resizable().scaledToFit()
                Button(action: {
                    print("$$$$$$$$$$$$")
                    print(auth.auth.currentUser!)
                    print(auth.auth.currentUser!)
                    print("$$$$$$$$$$$$")
                }, label:{
                    Text("test")})
                HStack{
//                Text("Enter your email:")
//                    .foregroundColor(.white)
//                TextField("Email", text: $email)
//                    .textContentType(.emailAddress)
//                    .cornerRadius(20)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .background(Color.white)
//                    .foregroundColor(.black)
//                    .padding(8)
//                    
//                }
//                HStack{
//                Text("Enter your password:")
//                    .foregroundColor(.white)
//                TextField("Password", text: $password)
//                    .textContentType(.password)
//                    .cornerRadius(20)
//                    .background(Color.white)
//                    .foregroundColor(.black)
//                    .padding(8)
                }
                NavigationLink(
                    destination: MultiPlayerGameView(gameNumber: gameNumber, color: color ), isActive: $showMultiplayerGame){
                    Button(action: {
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
                        listenToFireStore()
                    }){
                    Text("Sign In")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .background(Color.white)
                        .cornerRadius(40)
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

                    print("snapshot did not work \(err)")

                }

               }

            

        }

    }





