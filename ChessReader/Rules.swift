//
//  Rules.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

struct Rules{
    let lightPices = ["LR", "LN", "LB", "LK", "LQ", "LP"]
    let lightPicesAndNoPice = ["LR", "LN", "LB", "LK", "LQ", "LP", ""]
    let darkPices = ["BR", "BN", "BB", "BK", "BQ", "BP"]
    let darkPicesAndNoPice = ["BR", "BN", "BB", "BK", "BQ", "BP", ""]

    func inBord(row : Int, col : Int) -> Bool{
        if row >= 0 && row <= 7 && col >= 0 && col <= 7{
            
            return true
        }
        return false
    }
    
    func lightPawnEnPassant(bord: [[String]], enPassant: [Int], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if row == 3 {
            if  col - 1 >= 0 && col - 1 == enPassant[1] {
                moveList.append([2, col - 1])
            }
            if  col + 1 <= 7 && col + 1 == enPassant[1] {
                moveList.append([2, col + 1])
            }
        }
        return moveList
    }
    
    func darkPawnEnPassant(bord: [[String]], enPassant: [Int], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if row == 4 {
            if  col - 1 >= 0 && col - 1 == enPassant[0]{
                moveList.append([5, col - 1])
            }
            if  col + 1 <= 7 && col + 1 == enPassant[0]{
                moveList.append([5, col + 1])
            }
        }
        return moveList
    }
    
    func lightPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if bord[row - 1][col] == "" && row > 0  {
            moveList.append([row - 1, col,])
            if bord[row - 2][col] == "" && row == 6 {
                moveList.append([row - 2, col])
            }
        }
        if col > 0 && row > 0 && darkPices.contains(bord[row - 1][col - 1]) {
            moveList.append([row - 1, col - 1])
        }
        if col < 7 && row > 0 && darkPices.contains(bord[row - 1][col + 1]) {
            moveList.append([row - 1, col + 1])
        }
        return moveList
    }

    
    func darkPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if bord[row + 1][col] == "" && row > 0  {
            moveList.append([row + 1, col,])
            if bord[row + 2][col] == "" && row == 1 {
                moveList.append([row + 2, col])
            }
        }
        if col > 0 && row > 0 && lightPices.contains(bord[row + 1][col - 1]) {
            moveList.append([row + 1, col - 1])
        }
        if col < 7 && row > 0 && lightPices.contains(bord[row + 1][col + 1]) {
            moveList.append([row + 1, col + 1])
        }
        return moveList
    }
    
    func lightKing(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        
        if inBord(row: row, col: col + 1) && darkPicesAndNoPice.contains(bord[row][col + 1]){
            moveList.append([row, col + 1])
        }
        if inBord(row: row, col: col - 1) && darkPicesAndNoPice.contains(bord[row][col - 1]){
            moveList.append([row, col - 1])
        }
        if inBord(row: row + 1, col: col) && darkPicesAndNoPice.contains(bord[row + 1][col]){
            moveList.append([row + 1, col])
        }
        if inBord(row: row - 1, col: col) && darkPicesAndNoPice.contains(bord[row - 1][col]){
            moveList.append([row - 1, col])
        }
        if inBord(row: row + 1, col: col + 1) && darkPicesAndNoPice.contains(bord[row + 1][col + 1]){
            moveList.append([row + 1, col + 1])
        }
        if inBord(row: row - 1, col: col - 1) && darkPicesAndNoPice.contains(bord[row - 1][col - 1]){
            moveList.append([row - 1, col - 1])
        }
        if inBord(row: row + 1, col: col - 1) && darkPicesAndNoPice.contains(bord[row + 1][col - 1]){
            moveList.append([row + 1, col - 1])
        }
        if inBord(row: row - 1, col: col + 1) && darkPicesAndNoPice.contains(bord[row - 1][col + 1]){
            moveList.append([row - 1, col + 1])
        }
        
        
        return moveList
    }
    
    func darkKing(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row, col: col + 1) && lightPicesAndNoPice.contains(bord[row][col + 1]){
            moveList.append([row, col + 1])
        }
        if inBord(row: row, col: col - 1) && lightPicesAndNoPice.contains(bord[row][col - 1]){
            moveList.append([row, col - 1])
        }
        if inBord(row: row + 1, col: col) && lightPicesAndNoPice.contains(bord[row + 1][col]){
            moveList.append([row + 1, col])
        }
        if inBord(row: row - 1, col: col) && lightPicesAndNoPice.contains(bord[row - 1][col]){
            moveList.append([row - 1, col])
        }
        if inBord(row: row + 1, col: col + 1) && lightPicesAndNoPice.contains(bord[row + 1][col + 1]){
            moveList.append([row + 1, col + 1])
        }
        if inBord(row: row - 1, col: col - 1) && lightPicesAndNoPice.contains(bord[row - 1][col - 1]){
            moveList.append([row - 1, col - 1])
        }
        if inBord(row: row + 1, col: col - 1) && lightPicesAndNoPice.contains(bord[row + 1][col - 1]){
            moveList.append([row + 1, col - 1])
        }
        if inBord(row: row - 1, col: col + 1) && lightPicesAndNoPice.contains(bord[row - 1][col + 1]){
            moveList.append([row - 1, col + 1])
        }
        
        
        return moveList
    }
    
    func darkKnight(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row + 1, col: col + 2) && lightPicesAndNoPice.contains(bord[row + 1][col + 2]){
            moveList.append([row + 1 , col + 2])
        }
        if inBord(row: row + 1, col: col - 2) && lightPicesAndNoPice.contains(bord[row + 1][col - 2]){
            moveList.append([row + 1, col - 2])
        }
        if inBord(row: row - 1, col: col + 2) && lightPicesAndNoPice.contains(bord[row - 1][col + 2]){
            moveList.append([row - 1, col + 2])
        }
        if inBord(row: row - 1, col: col - 2) && lightPicesAndNoPice.contains(bord[row - 1][col - 2]){
            moveList.append([row - 1, col - 2])
        }
        if inBord(row: row + 2, col: col + 1) && lightPicesAndNoPice.contains(bord[row + 2][col + 1]){
            moveList.append([row + 2, col + 1])
        }
        if inBord(row: row + 2, col: col - 1) && lightPicesAndNoPice.contains(bord[row + 2][col - 1]) {
            moveList.append([row + 2, col - 1])
        }
        if inBord(row: row - 2, col: col + 1) && lightPicesAndNoPice.contains(bord[row - 2][col + 1]) {
            moveList.append([row - 2, col + 1])
        }
        if inBord(row: row - 2, col: col - 1) && lightPicesAndNoPice.contains(bord[row - 2][col - 1]) {
            moveList.append([row - 2, col - 1])
        }
        
        
        return moveList
    }
    
    func lightKnight(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row + 1, col: col + 2) && darkPicesAndNoPice.contains(bord[row + 1][col + 2]) {
            moveList.append([row + 1 , col + 2])
        }
        if inBord(row: row + 1, col: col - 2) && darkPicesAndNoPice.contains(bord[row + 1][col - 2]) {
            moveList.append([row + 1, col - 2])
        }
        if inBord(row: row - 1, col: col + 2) && darkPicesAndNoPice.contains(bord[row - 1][col + 2]){
            moveList.append([row - 1, col + 2])
        }
        if inBord(row: row - 1, col: col - 2) && darkPicesAndNoPice.contains(bord[row - 1][col - 2]){
            moveList.append([row - 1, col - 2])
        }
        if inBord(row: row + 2, col: col + 1) && darkPicesAndNoPice.contains(bord[row + 2][col + 1]){
            moveList.append([row + 2, col + 1])
        }
        if inBord(row: row + 2, col: col - 1) && darkPicesAndNoPice.contains(bord[row + 2][col - 1]){
            moveList.append([row + 2, col - 1])
        }
        if inBord(row: row - 2, col: col + 1) && darkPicesAndNoPice.contains(bord[row - 2][col + 1]){
            moveList.append([row - 2, col + 1])
        }
        if inBord(row: row - 2, col: col - 1) && darkPicesAndNoPice.contains(bord[row - 2][col - 1]){
            moveList.append([row - 2, col - 1])
        }
        
        return moveList
    }
    
    func darkBishop(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        var x = 1
        var y = 1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = 1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y =  1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        return moveList
    }
    
    
    func lightBishop(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        var x = 1
        var y = 1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = 1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y =  1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        return moveList
        
    }
    
    func darkRook (bord: [[String]], row: Int, col: Int) -> [[Int]] {
           var moveList = [[Int]]()
           var x = 1
           var y = 1
           
           while inBord(row: row + x, col:col) && bord[row + x][col] == ""{
               moveList.append([row + x, col])
               x = x + 1
           }
       
           if inBord(row: row + x, col: col) && lightPices.contains(bord[row + x][col]){
               moveList.append([row + x, col])
           }
           x = 1
           
           
           while inBord(row: row - x, col:col) && bord[row - x][col] == ""{
               moveList.append([row - x, col])
               x = x + 1
           }
       
           if inBord(row: row - x, col: col) && lightPices.contains(bord[row - x][col]){
               moveList.append([row - x, col])
           }
           x = 1
           
           while inBord(row: row , col:col + y) && bord[row][col + y] == ""{
               moveList.append([row, col + y])
               y = y + 1
           }
       
           if inBord(row: row , col: col + y) && lightPices.contains(bord[row][col + y]){
               moveList.append([row, col + y])
           }
           y = 1
           
           while inBord(row: row , col:col - y) && bord[row][col - y] == ""{
               moveList.append([row, col - y])
               y = y + 1
           }
       
           if inBord(row: row , col: col - y) && lightPices.contains(bord[row][col - y]){
               moveList.append([row, col - y])
           }
           y = 1
           
           
           return moveList
       }
    
    func lightRook (bord: [[String]], row: Int, col: Int) -> [[Int]] {
           var moveList = [[Int]]()
           var x = 1
           var y = 1
           
           while inBord(row: row + x, col:col) && bord[row + x][col] == ""{
               moveList.append([row + x, col])
               x = x + 1
           }
       
           if inBord(row: row + x, col: col) && darkPices.contains(bord[row + x][col]){
               moveList.append([row + x, col])
           }
           x = 1
           
           
           while inBord(row: row - x, col:col) && bord[row - x][col] == ""{
               moveList.append([row - x, col])
               x = x + 1
           }
       
           if inBord(row: row - x, col: col) && darkPices.contains(bord[row - x][col]){
               moveList.append([row - x, col])
           }
           x = 1
           
           while inBord(row: row , col:col + y) && bord[row][col + y] == ""{
               moveList.append([row, col + y])
               y = y + 1
           }
       
           if inBord(row: row , col: col + y) && darkPices.contains(bord[row][col + y]){
               moveList.append([row, col + y])
           }
           y = 1
           
           while inBord(row: row , col:col - y) && bord[row][col - y] == ""{
               moveList.append([row, col - y])
               y = y + 1
           }
       
           if inBord(row: row , col: col - y) && darkPices.contains(bord[row][col - y]){
               moveList.append([row, col - y])
           }
           y = 1
           
           
           return moveList
       }
    
    func darkQueen(bord: [[String]], row: Int, col: Int) -> [[Int]]{
        return darkBishop(bord: bord, row: row, col: col) +  darkRook(bord: bord, row: row, col: col)
    }
    
    func lightQueen(bord: [[String]], row: Int, col: Int) -> [[Int]]{
        return lightBishop(bord: bord, row: row, col: col) +  lightRook(bord: bord, row: row, col: col)
    }
    
    func getPiecesPositions(bord: [[String]], piece: String ) -> [[Int]] {
        var positions = [[Int]]()
        for row in 0...7 {
            for col in 0...7 {
                if bord[row][col] == piece {
                    positions.append([row, col])
                }
            }
        }
        return positions
    }
    
}
