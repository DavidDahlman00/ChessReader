//
//  Tmp3View.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-03.
//

import SwiftUI

struct Tmp3View: View {
    @ObservedObject var bord = Bord()
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 14.0/255.0, green: 14.0/255.0, blue: 38.0/255.0)
                VStack{
                    Text("Multiplayer")
                    
                        
                    BordView(bord: bord, imageSize: 0.92 * geo.size.width / 8, image: bord.bord)
                    HStack{
                        Button(action: {
                            if bord.bord[3][3] == "" {
                                bord.bord[3][3] = bord.bord[1][3]
                                bord.bord[1][3] = ""
                            }else{
                                bord.bord[1][3] = bord.bord[3][3]
                                bord.bord[3][3] = ""
                             }
                        }) {
                            Image(systemName: "backward.fill")
                        }
                        .foregroundColor(.gray)
                        
                        Button(action: {
                            if bord.bord[4][3] == "" {
                                bord.bord[4][3] = bord.bord[6][3]
                                bord.bord[6][3] = ""
                            }else{
                                bord.bord[6][3] = bord.bord[4][3]
                                bord.bord[4][3] = ""
                             }
                        }) {
                            Image(systemName: "forward.fill")
                        }
                        
                        .foregroundColor(.gray)
                    }
                    // knappar och annat
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct Tmp3View_Previews: PreviewProvider {
    static var previews: some View {
        Tmp3View()
    }
}


