//
//  WaitingForMultiPlayerView.swift
//  ChessReader
//
//  Created by Axel Söderberg on 2021-02-08.
//

import Firebase
import SwiftUI

struct WaitingForMultiPlayerView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView{
        ZStack{
            Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
            Image("chessTest").resizable().scaledToFit()
            VStack{
                HStack{
                Text("Enter your email:")
                    .foregroundColor(.white)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .cornerRadius(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .foregroundColor(.black)
                    .padding(8)
                    
                }
                HStack{
                Text("Enter your password:")
                    .foregroundColor(.white)
                TextField("Password", text: $password)
                    .textContentType(.password)
                    .cornerRadius(20)
                    
                    .background(Color.white)
                    .foregroundColor(.black)
                    .padding(8)
                }
                NavigationLink(
                    destination: MultiPlayerGameView()){
                    Text("Sign In")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .overlay(RoundedRectangle)
                        .background(Color.white)
                        .cornerRadius(40)
                        .padding(30)
                }
            }
               
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
      
   }





struct  WaitingForMultiPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForMultiPlayerView(email: "", password: "")
    }
}
