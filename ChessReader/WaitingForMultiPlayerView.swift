//
//  WaitingForMultiPlayerView.swift
//  ChessReader
//
//  Created by Axel Söderberg on 2021-02-08.
//

import Firebase
import SwiftUI

struct WaitingForMultiPlayerView: View {
    @State var showMultiplayerGame: Bool = false
    @ObservedObject var auth: GlobalAuth
    @State var email: String = ""
    @State var password: String = ""
    
    
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
                    destination: MultiPlayerGameView(), isActive: $showMultiplayerGame){
                    Button(action: {
                        
                        showMultiplayerGame = true
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
}





