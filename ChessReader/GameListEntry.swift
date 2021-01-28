//
//  GameListEntry.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-27.
//

import Foundation

struct GameListEntry: Identifiable {
    var id = UUID()
    var game : String
    var coment : String? = nil
    
}
