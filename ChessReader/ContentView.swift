//
//  ContentView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-25.
//

import SwiftUI
import FirebaseAuth

class GlobalAuth: ObservableObject {
    @Published var auth = Auth.auth()
}

struct ContentView: View {
    @ObservedObject var auth = GlobalAuth()

    init() {
     
        auth.auth.signInAnonymously{ (result, err) in
            print("!!!!!!!!")
            if let err = err {
                
                
                print(err.localizedDescription)
                print("!!!!!!!!!!")
                return
            }
            
            print("Success Auth")
        }
    }
    var body: some View {
        //Image("chessImage")
        TabView{
            
            SinglePlayerGameView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Singleplayer game")
                    
                    
                }
            WaitingForMultiPlayerView(auth: auth)
                .tabItem{
                    Image(systemName: "person.2.fill")
                    Text("multiplayer game")
                    
                }
            
            ReadGameView()
                .tabItem{
                    Image(systemName: "text.book.closed.fill")
                    Text("Read games")
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




