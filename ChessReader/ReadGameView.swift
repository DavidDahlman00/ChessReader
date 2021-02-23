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
        UINavigationBar.appearance()
            //.largeTitleTextAttributes = [.foregroundColor: UIColor.gray]
    }
    
     var body: some View {
        
           
         NavigationView{
            ZStack{
                Color("BackGroundColor").edgesIgnoringSafeArea(.all)
             List() {
                 ForEach(gameList.entries){ entry in
                    NavigationLink(destination: ChessBordView()){ // temp removed playedGame: entry
                         ListRowView(entry: entry)
                            
                     }
                    .listRowBackground(Color("BackGroundColor"))
                    
                 }.onDelete(perform: { indexSet in
                     gameList.entries.remove(atOffsets: indexSet)
                 })
             }
            
             //.navigationBarTitle("Chess Reader")
             
             
//             .navigationBarItems(trailing: NavigationLink(destination: ChessBordView(), label: {Image(systemName: "plus.circle")}))
             
            }
            
                
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
                .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                .font(.title)
        }
    }
}

