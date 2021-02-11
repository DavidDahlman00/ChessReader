
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
            Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
            Image("chessTest").resizable().scaledToFit()
            VStack{
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
            for document in snapshot!.documents {
                if document["waiting"] as! Bool == false {
                    showMultiplayerGame = true
                }
               }
           }
    }
}





