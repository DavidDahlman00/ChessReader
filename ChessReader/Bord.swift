//
//  Bord.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

class Bord: ObservableObject {

     @Published var bord : [[String]]

    

    init() {

        bord = [["BR", "BN", "BB", "BK", "BQ", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["WP","WP","WP","WP","WP","WP","WP","WP"], ["WR", "WN", "WB", "WK", "WQ", "WB", "WN", "WR"]]

    }

    

}
