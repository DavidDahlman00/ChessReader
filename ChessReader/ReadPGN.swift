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
    var testPGN = """

[Event "URS-ch40"]
[Site "Baku"]
[Date "1972.??.??"]
[Round "?"]
[White "Mukhin, Mikhail A"]
[Black "Tukmakov, Vladimir B"]
[Result "1/2-1/2"]
[WhiteElo "2420"]
[BlackElo "2560"]
[ECO "E63"]

1.c4 Nf6 2.d4 g6 3.Nf3 Bg7 4.g3 O-O 5.Bg2 d6 6.O-O Nc6 7.Nc3 a6 8.Bd2 Rb8
9.Rc1 b5 10.cxb5 axb5 11.d5 Na5 12.b4 Nc4 13.Be1 Bd7 14.Nd4 Qe8 15.Nc6 Rb7
16.a4 Nb2 17.Qc2 Nxa4 18.Nxa4 bxa4 19.Qxa4 e6 20.e4 exd5 21.exd5 Ne4 22.Qa6 Bc8
23.Qc4 f5 24.f3 Nf6 25.Bf2 Qf7 26.Rfe1 Re8 27.Rxe8+ Nxe8 28.Nd8 Qd7 29.Nxb7 Bxb7
30.f4 Kf7 31.Qe2 Kf8 32.Qc4 Qa4 33.h3 Ba6  1/2-1/2

"""
    
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
    
    func readGame() {
        var i = 0
        var tmpBuffert = ""
        while tmpBuffert != "1/2-1/2" && i < 500 {
            if getCurrentChar() == "[" {
                moveForward()
                while getCurrentChar() != "]" {
                    information.append(getCurrentChar())
                    moveForward()
                }
                information.append("\n")
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
    }
    
}
