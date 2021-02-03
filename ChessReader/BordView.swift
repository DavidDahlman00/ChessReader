//
//  BordView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-03.
//

import Foundation
import SwiftUI

struct BordView: View {
   @ObservedObject var bord: Bord
    let imageSize: CGFloat
    var image: [[String]]
    var body: some View {
        VStack(spacing: 0){
            RowView(bord: bord, imageSize: imageSize, row: 0, image: image[0])
            RowView(bord: bord, imageSize: imageSize, row: 1, image: image[1])
            RowView(bord: bord, imageSize: imageSize, row: 2, image: image[2])
            RowView(bord: bord, imageSize: imageSize, row: 3, image: image[3])
            RowView(bord: bord, imageSize: imageSize, row: 4, image: image[4])
            RowView(bord: bord, imageSize: imageSize, row: 5, image: image[5])
            RowView(bord: bord, imageSize: imageSize, row: 6, image: image[6])
            RowView(bord: bord, imageSize: imageSize, row: 7, image: image[7])
        }
        .padding()
    }
}

struct RowView: View {
    @ObservedObject var bord: Bord
    let imageSize: CGFloat
    let row: Int
    let image: [String]
    
    var body: some View {
        HStack(spacing: 0){
            SquareView(bord: bord, size: imageSize, pice: image[0], row: row, col: 0)
            SquareView(bord: bord, size: imageSize, pice: image[1], row: row, col: 1)
            SquareView(bord: bord, size: imageSize, pice: image[2], row: row, col: 2)
            SquareView(bord: bord, size: imageSize, pice: image[3], row: row, col: 3)
            SquareView(bord: bord, size: imageSize, pice: image[4], row: row, col: 4)
            SquareView(bord: bord, size: imageSize, pice: image[5], row: row, col: 5)
            SquareView(bord: bord, size: imageSize, pice: image[6], row: row, col: 6)
            SquareView(bord: bord, size: imageSize, pice: image[7], row: row, col: 7)

        }
    }
}

struct SquareView: View {
    @ObservedObject var bord: Bord
    var size: CGFloat
    var color: Color{
        switch bord.activityBord[row][col] {
        case "none":
            if (row + col).isMultiple(of: 2) {
                return Color(red: 171.0/255.0, green: 171.0/255.0, blue: 171.0/255.0)
            }else{
                return Color(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0)
            }
        case "active":
            if (row + col).isMultiple(of: 2) {
                return Color(red: 19.0/255.0, green: 196.0/255.0, blue: 202.0/255.0)
            }else{
                return Color(red: 12.0/255.0, green: 119.0/255.0, blue: 122.0/255.0)
            }
        case "inMoveList":
            if (row + col).isMultiple(of: 2) {
                return Color(red: 21.0/255.0, green: 239.0/255.0, blue: 246.0/255.0)
            }else{
                return Color(red: 16.0/255.0, green: 156.0/255.0, blue: 161.0/255.0)
            }
        default:
            return Color(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0)
        }
    }
    var pice: String
    let row: Int
    let col: Int
    var body: some View {
        ZStack{
            color
                .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
            Button(action: {
                print("test \(row), \(col)")
                bord.squareTuched(row: row, col: col)
                print(bord.activityBord[row][col])

                
            }) {
                Image(bord.bord[row][col])
                    .resizable()
                    .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
}
