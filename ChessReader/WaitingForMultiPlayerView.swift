//
//  WaitingForMultiPlayerView.swift
//  ChessReader
//
//  Created by Axel Söderberg on 2021-02-08.
//

import Firebase
import SwiftUI



struct WaitingForMultiPlayerView: View {
    var email: String = ""
    var password: String = ""
    var body: some View {
        ZStack{
            Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
            Image("chessTest").resizable().scaledToFit()
            VStack{
                
            

                
            }
        }.edgesIgnoringSafeArea(.all)
        
        
            }
}




struct  WaitingForMultiPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForMultiPlayerView(email: "", password: "")
    }
}
