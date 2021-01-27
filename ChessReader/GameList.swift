//
//  GameList.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-27.
//

import Foundation

class GameList: ObservableObject {
    @Published var entries = [GameListEntry]()
    
    init() {
        addMocData()
    }
    
    func addMocData() {
        entries.append(GameListEntry(game: "Saker att göra eller skjutas på måste"))
        entries.append(GameListEntry(game: "titta på film"))
        entries.append(GameListEntry(game: "gjort något viktigt"))
        entries.append(GameListEntry(game: "... men kunde också gjort något annat"))
    }
}
