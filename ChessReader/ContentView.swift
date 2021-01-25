//
//  ContentView.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-25.
//

import SwiftUI

struct ContentView: View {
    var size: CGFloat = 30
    @State var image = "Chess_plt60"
    var body: some View {
        ZStack{
            VStack{
                // text och annat
                ExtractedView()
                VStack{
                    Button(action: {
                        //vad knappen gör
                    }){
                        Image(systemName: "back")
                        //hur knappen ser ut
                    }
                    Button(action: {
                        //vad knappen gör
                    }){
                        Image(systemName: "forward")
                        //hur knappen ser ut
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

struct ExtractedView: View {
    var size: CGFloat = 30
    @State var image = "Chess_plt60"
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                ZStack{
                    Color(red: 0.02, green: 0.77, blue: 0.42)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                ZStack{
                    Color(red: 0.1, green: 0.1, blue: 0.1)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                ZStack{
                    Color(red: 0.02, green: 0.77, blue: 0.42)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                ZStack{
                    Color(red: 0.1, green: 0.1, blue: 0.1)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                ZStack{
                    Color(red: 0.02, green: 0.77, blue: 0.42)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: .center)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                ZStack{
                    Color(red: 0.1, green: 0.1, blue: 0.1)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                ZStack{
                    Color(red: 0.02, green: 0.77, blue: 0.42)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                ZStack{
                    Color(red: 0.1, green: 0.1, blue: 0.1)
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode:.fit).frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
            }
        }
    }
}
