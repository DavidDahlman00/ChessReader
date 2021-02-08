//
//  Tmp1View.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-03.
//

import SwiftUI

struct ReadGameView: View {
    @ObservedObject var gameList = GameList()
    init(){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.gray]
    }
    
     var body: some View {
        
           
         NavigationView{
            ZStack{
                Color(red: 14.0/255.0, green: 14.0/255.0, blue: 31.0/255.0).edgesIgnoringSafeArea(.all)
             List() {
                 ForEach(gameList.entries){ entry in
                    NavigationLink(destination: ChessBordView(playedGame: entry)){
                         ListRowView(entry: entry)
                            
                     }
                    .listRowBackground(Color(red: 14.0/255.0, green: 14.0/255.0, blue: 31.0/255.0))
                    
                 }.onDelete(perform: { indexSet in
                     gameList.entries.remove(atOffsets: indexSet)
                 })
             }
             
             .foregroundColor(.gray)
             .navigationBarTitle("Chess Reader")
             
             .navigationBarItems(trailing: NavigationLink(destination: ChessBordView(), label: {Image(systemName: "plus.circle")}))
             
            }
            .foregroundColor(.red)
                
         }
         
     }
}

struct ReadGame_Previews: PreviewProvider {
    static var previews: some View {
        ReadGameView()
    }
}


struct ListRowView: View {
    var entry : GameListEntry
   
    
    var body: some View {
        HStack {
           
            Spacer()
            Text(entry.game.prefix(30) + "   ")
        }
    }
}

