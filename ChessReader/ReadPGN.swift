//
//  ReadPGN.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-02-16.
//

import Foundation


class ReadPGN {
    var testPGNInt = 0
    var information: String = ""
    var darkMoveList = [String]()
    var lightMoveList = [String]()
    var player = "light"
    var result: String = ""
    var testPGN : String
    var winner = ""
        
    init(testPGN: String) {
        self.testPGN = testPGN
    }
    
    func moveForward() {
        if testPGNInt < testPGN.count - 1{
            testPGNInt = testPGNInt + 1
        }
    }
    
    func moveBackward() {
        if testPGNInt > 0{
            testPGNInt = testPGNInt - 1
        }
    }
    
    
    func getCurrentChar() -> String {
        if testPGNInt < testPGN.count - 1 && testPGNInt > 0 {
            return testPGN[testPGNInt]
        }
        return ""
    }
    
    // sets information, light and dark movelist from PGN string.
    func readGame() {
        var i = 0
        let endText = ["1-0","1-", "0-1", "0-", "1/2-1/2", "1/2-1/"]
        var tmpBuffert = ""
        while !endText.contains(tmpBuffert) && i < 3000 {
            if getCurrentChar() == "[" {
                moveForward()
                while getCurrentChar() != "]" {
                    information.append(getCurrentChar())
                    moveForward()
                }
                information.append("\n")
                moveForward()
            }else if getCurrentChar() == " " {
                if tmpBuffert != "" {
                    if player == "light"{
                        lightMoveList.append(tmpBuffert)
                        player = "dark"
                    }else{
                        darkMoveList.append(tmpBuffert)
                        player = "light"
                    }
                }
                tmpBuffert = ""
                moveForward()
            }else if getCurrentChar() == "\n" {
                if tmpBuffert != "" {
                    if player == "light"{
                        lightMoveList.append(tmpBuffert)
                        player = "dark"
                    }else{
                        darkMoveList.append(tmpBuffert)
                        player = "light"
                    }
                }
                tmpBuffert = ""
                moveForward()
            }else if getCurrentChar() == "." {
                tmpBuffert = ""
                moveForward()
            }else {
                tmpBuffert.append(getCurrentChar())
                moveForward()
            }
         i = i + 1
        }
        print(tmpBuffert)
        print(i)
        information = information.filter{ $0 != "\""}
        testPGNInt = 0
        if ["1-0", "1-"].contains(tmpBuffert) {
            winner = "white"
        }else if ["0-1", "0-"].contains(tmpBuffert) {
            winner = "black"
        }else if ["1/2-1/2", "1/2-1/"].contains(tmpBuffert){
            winner = "draw"
        }else{
            winner = "Error: game wasn't read correctly"
        }
    }
    
    
}
