import Foundation

struct GameListEntry: Identifiable {
    var id = UUID()
    var ocation : String? = nil
    var players : String? = nil
    var game : String
    
}
