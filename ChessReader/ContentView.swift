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
            Tmp1View()
                .tabItem{
                    Image(systemName: "text.book.closed.fill")
                    Text("Read games")
                }
            Tmp2View()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Single game")
                }
            Tmp3View()
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




