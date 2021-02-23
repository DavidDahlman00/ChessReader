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
        entries.append(GameListEntry(ocation: "David - Axel", players: "Best game ever!"))
        entries.append(GameListEntry(ocation: "Magnus - Fabiano"))
        entries.append(GameListEntry(ocation: "Liren - Ian"))
        entries.append(GameListEntry(ocation: "Maxime - Alexander"))
        entries.append(GameListEntry(ocation: "Levon - Wesley"))
        entries.append(GameListEntry(ocation: "Teimour - Anish"))
        
    }
}
