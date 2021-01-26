//
//  ContentView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-25.
//

import SwiftUI

struct ContentView: View {
    @State var bord: [[String]] = [["blackRock", "blackKnight", "blackBishop", "blackKing", "blackQueen", "blackBishop", "blackKnight", "blackRock"], ["blackPawn","blackPawn","blackPawn","blackPawn","blackPawn","blackPawn","blackPawn","blackPawn"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn"], ["whiteRock", "whiteKnight", "whiteBishop", "whiteKing", "whiteQueen", "whiteBishop", "whiteKnight", "whiteRock"]]
    var body: some View {
        GeometryReader{geo in
            ZStack{
                VStack{
                    // text och annat
                    BordView(imageSize: 0.92 * geo.size.width / 8, image: bord)
                        
                    Button("Test"){
                        if bord[3][3] == "" {
                            bord[3][3] = bord[1][3]
                            bord[1][3] = ""
                        }else{
                            bord[1][3] = bord[3][3]
                            bord[3][3] = ""
                         }
                    }
                    // knappar och annat
                }
                
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
    let imageSize: CGFloat
    var image: [[String]]
    var body: some View {
        VStack(spacing: 0){
            RowView(imageSize: imageSize, row: 0, image: image[0])
            RowView(imageSize: imageSize, row: 1, image: image[1])
            RowView(imageSize: imageSize, row: 2, image: image[2])
            RowView(imageSize: imageSize, row: 3, image: image[3])
            RowView(imageSize: imageSize, row: 4, image: image[4])
            RowView(imageSize: imageSize, row: 5, image: image[5])
            RowView(imageSize: imageSize, row: 6, image: image[6])
            RowView(imageSize: imageSize, row: 7, image: image[7])
        }
        .padding()
    }
}

struct RowView: View {
    let imageSize: CGFloat
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
            SquareView(size: imageSize, color: color1, pice: image[0])
            SquareView(size: imageSize, color: color2, pice: image[1])
            SquareView(size: imageSize, color: color1, pice: image[2])
            SquareView(size: imageSize, color: color2, pice: image[3])
            SquareView(size: imageSize, color: color1, pice: image[4])
            SquareView(size: imageSize, color: color2, pice: image[5])
            SquareView(size: imageSize, color: color1, pice: image[6])
            SquareView(size: imageSize, color: color2, pice: image[7])

        }
    }
}

struct SquareView: View {
    var size: CGFloat
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
