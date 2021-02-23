//
//  GameListEntry.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-27.
//

import Foundation

struct GameListEntry: Identifiable {
    var id = UUID()
    var ocation : String? = nil
    var players : String? = nil
    
}
