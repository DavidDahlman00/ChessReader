//
//  GameList.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-27.
//

import Foundation
import Firebase

class GameList: ObservableObject {
    @Published var entries = [GameListEntry]()
    var db = Firestore.firestore()
    
    init() {
        addMocData()
    }
    
    func addMocData() {
        entries.append(GameListEntry(ocation: "David - Axel", players: "Best game ever!", game: ""))
        entries.append(GameListEntry(ocation: "Magnus - Fabiano", game: ""))
        entries.append(GameListEntry(ocation: "Liren - Ian", game: ""))
        entries.append(GameListEntry(ocation: "Maxime - Alexander", game: ""))
        entries.append(GameListEntry(ocation: "Levon - Wesley", game: ""))
        entries.append(GameListEntry(ocation: "Teimour - Anish", game: ""))
        
      
        listenToFireStore()
        
    }
    
    func listenToFireStore() {
           
           db.collection("gameList").addSnapshotListener{ (snapshot, err) in

               for document in snapshot!.documents {
                let ocation = document["ocation"] ?? "Unknown Ocation"
                let players = document["players"] ?? "?? - ??"
                let game = document["game"] ?? "Error should not be empty"
                self.entries.append(GameListEntry(ocation: ocation as? String, players: players as? String, game: game as! String))
               }
           }
    }
}
