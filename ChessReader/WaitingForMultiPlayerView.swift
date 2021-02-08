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
        ZStack{
            Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
            Image("chessTest").resizable().scaledToFit()
            VStack{
               
            
                TextField("Enter your email", text: $email).foregroundColor(.red).foregroundColor(.red)
                
                TextField("Enter your password", text: $password).foregroundColor(.red).foregroundColor(.red)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Press me").foregroundColor(.red)
                })

                
            }
        }.edgesIgnoringSafeArea(.all)
       
            }
}




struct  WaitingForMultiPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForMultiPlayerView(email: "", password: "")
    }
}
