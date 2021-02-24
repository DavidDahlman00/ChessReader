import SwiftUI

struct ReadGameView: View {
    
    @State private var searchTerm: String = ""
    
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
                VStack{
                SearchBar(text: $searchTerm)
             List {
            
                ForEach(self.gameList.entries.filter {
                            self.searchTerm.isEmpty ? true: $0.ocation?.localizedStandardContains(self.searchTerm) as! Bool ||   $0.players?.localizedStandardContains(self.searchTerm) as! Bool            }){ entry in
                    NavigationLink(destination: ChessBordView(playedGame: entry)){  //playedGame: entry
                        VStack{
                           ListRowView(entry: entry)
                        }
                     }
                    .listRowBackground(Color("BackGroundColor"))
                    
                 }.onDelete(perform: { indexSet in
                     gameList.entries.remove(atOffsets: indexSet)
                 })
             }
                }
                .navigationBarTitle("Chess Reader")
                
//             .navigationBarItems(trailing: NavigationLink(destination: SinglePlayerGameView(), label: {Image(systemName: "magnifyingglass.circle")}))
             
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
        VStack {
           
            Spacer()
            Text(entry.ocation ?? "Unknown event")
                .gradientForeground(colors: [Color("TextColor1"), Color("TextColor2")])
                .font(.title)
            Text(entry.players ?? "??")
                .foregroundColor(.gray)
                .font(.footnote)
            Spacer()
        }.shadow(color: .gray, radius: 1.0, x: 0, y: 0)
    }
}

