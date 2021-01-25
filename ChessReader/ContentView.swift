//
//  ContentView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack{
            VStack{
                // text och annat
                BordView()
                // knappar och annat
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BordView: View {
  
    @State var image = [["blackRock", "blackKnight", "blackBishop", "blackKing", "blackQueen", "blackBishop", "blackKnight", "blackRock"], ["blackPawn","blackPawn","blackPawn","blackPawn","blackPawn","blackPawn","blackPawn","blackPawn"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn"], ["whiteRock", "whiteKnight", "whiteBishop", "whiteKing", "whiteQueen", "whiteBishop", "whiteKnight", "whiteRock"]]
    var body: some View {
        VStack(spacing: 0){
            RowView(row: 0, image: image[0])
            RowView(row: 1, image: image[1])
            RowView(row: 2, image: image[2])
            RowView(row: 3, image: image[3])
            RowView(row: 4, image: image[4])
            RowView(row: 5, image: image[5])
            RowView(row: 6, image: image[6])
            RowView(row: 7, image: image[7])
        }
    }
}

struct RowView: View {
    var size: CGFloat = 44
    let row: Int
    let image: [String]
    var color1: Color{
        if row.isMultiple(of: 2) {
            return Color(red: 171.0/255.0, green: 171.0/255.0, blue: 171.0/255.0)
        }else{
            return Color(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0)
        }
    }
    var color2: Color{
        if row.isMultiple(of: 2) {
            return Color(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0)
        }else{
            return Color(red: 171.0/255.0, green: 171.0/255.0, blue: 171.0/255.0)
        }
    }
        
    
    var body: some View {
        HStack(spacing: 0){
            SquareView(color: color1, pice: image[0])
            SquareView(color: color2, pice: image[1])
            SquareView(color: color1, pice: image[2])
            SquareView(color: color2, pice: image[3])
            SquareView(color: color1, pice: image[4])
            SquareView(color: color2, pice: image[5])
            SquareView(color: color1, pice: image[6])
            SquareView(color: color2, pice: image[7])

        }
    }
}

struct SquareView: View {
    var size: CGFloat = 44
    let color: Color
    var pice: String
    var body: some View {
        ZStack{
            color
                .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Image(pice)
                .resizable()
                .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }
    }
}
