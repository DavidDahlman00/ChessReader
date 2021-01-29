//
//  ChessBordView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-27.
//

import SwiftUI

struct ChessBordView : View {
    var playedGame : GameListEntry? = nil
    var testText: String = "Test"
    @State var bord: [[String]] = [["BR", "BN", "BB", "BK", "BQ", "BB", "BN", "BR"], ["BP","BP","BP","BP","BP","BP","BP","BP"], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["","","","","","","",""], ["WP","WP","WP","WP","WP","WP","WP","WP"], ["WR", "WN", "WB", "WK", "WQ", "WB", "WN", "WR"]]
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
                VStack{
                    // text och annat
                    Text(playedGame?.game ?? "Unknown Game")
                        .foregroundColor(.gray)
                        .bold()
                        
                    BordView(imageSize: 0.92 * geo.size.width / 8, image: bord)
                    HStack{
                        Button(action: {
                            if bord[3][3] == "" {
                                bord[3][3] = bord[1][3]
                                bord[1][3] = ""
                            }else{
                                bord[1][3] = bord[3][3]
                                bord[3][3] = ""
                             }
                        }) {
                            Image(systemName: "backward.fill")
                        }
                        .foregroundColor(.gray)
                        
                        Button(action: {
                            if bord[4][3] == "" {
                                bord[4][3] = bord[6][3]
                                bord[6][3] = ""
                            }else{
                                bord[6][3] = bord[4][3]
                                bord[4][3] = ""
                             }
                        }) {
                            Image(systemName: "forward.fill")
                        }
                        
                        .foregroundColor(.gray)
                    }
                    
                    Text(playedGame?.coment ?? "Nobody coment this game, yet")
                        .foregroundColor(.gray)
                        .bold()
                    
                    
                    // knappar och annat
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
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
            SquareView(size: imageSize, color: color1, pice: image[0], row: row, col: 0)
            SquareView(size: imageSize, color: color2, pice: image[1], row: row, col: 1)
            SquareView(size: imageSize, color: color1, pice: image[2], row: row, col: 2)
            SquareView(size: imageSize, color: color2, pice: image[3], row: row, col: 3)
            SquareView(size: imageSize, color: color1, pice: image[4], row: row, col: 4)
            SquareView(size: imageSize, color: color2, pice: image[5], row: row, col: 5)
            SquareView(size: imageSize, color: color1, pice: image[6], row: row, col: 6)
            SquareView(size: imageSize, color: color2, pice: image[7], row: row, col: 7)

        }
    }
}

struct SquareView: View {
    var size: CGFloat
    let color: Color
    var pice: String
    let row: Int
    let col: Int
    var body: some View {
        ZStack{
            color
                .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            Image(pice)
//                .resizable()
//                .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: {
                print("test \(row), \(col)")
            }) {
                Image(pice)
                    .resizable()
                    .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
}

struct ChessBordView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
