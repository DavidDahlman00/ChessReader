import Foundation

class GameList: ObservableObject {
    @Published var entries = [GameListEntry]()
    
    init() {
        addMocData()
    }
    
    func addMocData() {
        entries.append(GameListEntry(game: "David - Axel", coment: "Best game ever!"))
        entries.append(GameListEntry(game: "Magnus - Fabiano"))
        entries.append(GameListEntry(game: "Liren - Ian"))
        entries.append(GameListEntry(game: "Maxime - Alexander"))
        entries.append(GameListEntry(game: "Levon - Wesley"))
        entries.append(GameListEntry(game: "Teimour - Anish"))
        
    }
}
