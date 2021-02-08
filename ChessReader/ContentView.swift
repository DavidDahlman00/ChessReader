//
//  ContentView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Image("chessImage")
        TabView{
            ReadGameView()
                .tabItem{
                    Image(systemName: "text.book.closed.fill")
                    Text("Read games")
                }
            SinglePlayerGameView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Singleplayer game")
                    
                    
                }
            WaitingForMultiPlayerView()
                .tabItem{
                    Image(systemName: "person.2.fill")
                    Text("multiplayer game")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




