//
//  ContentView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameList = GameList()
     var body: some View {
         
         NavigationView{
             
             List() {
                 ForEach(gameList.entries){ entry in
                    NavigationLink(destination: ChessBordView()){
                         ListRowView(entry: entry)
                     }
                 }.onDelete(perform: { indexSet in
                     gameList.entries.remove(atOffsets: indexSet)
                 })
             }
             .navigationBarTitle("Chess Reader")
             .navigationBarItems(trailing: NavigationLink(destination: ChessBordView(), label: {Image(systemName: "plus.circle")}))
         }

     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ListRowView: View {
    var entry : GameListEntry
   
    
    var body: some View {
        HStack {
           
            Spacer()
            Text(entry.game.prefix(20) + "...")
        }
    }
}
