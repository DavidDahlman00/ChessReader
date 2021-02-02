//
//  Rules.swift
//  ChessReader
//
//  Created by David Dahlman on 2021-01-29.
//

import Foundation

struct Rules{


func inBord(row : Int, col : Int) -> Bool{
        if row >= 0 && row <= 7 && col >= 0 && col <= 7{
            
            return true
        }
        return false
    }
    
//    func LightPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
//        var moveList = [[Int]]()
//        if bord[row - 1][col] == "" && row > 0  {
//            moveList.append([row - 1, col,])
//            if bord[row - 2][col] == "" && row == 6 {
//                moveList.append([row - 2, col,])
//            }
//        }
//        if ["DR", "DN", "DB", "DK", "DQ", "DP"].contains(bord[row - 1][col - 1]) && col > 0 && row > 0 {
//            moveList.append([row - 1, col - 1])
//        }
//        if ["DR", "DN", "DB", "DK", "DQ", "DP"].contains(bord[row - 1][col + 1]) && col < 7 && row > 0 {
//            moveList.append([row - 1, col - 1])
//        }
//        return moveList
//    }
    
//    func DarkPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
//        var moveList = [[Int]]()
//
//
//        if bord[row + 1][col] == "" && row < 0  {
//            moveList.append([row + 1, col,])
//            if bord[row + 2][col] == "" && row == 1 {
//                moveList.append([row + 2, col,])
//            }
//        }
//        if ["LR", "LN", "LB", "LK", "BQ", "LP"].contains(bord[row + 1][col + 1]) && col < 0 && row < 0 {
//            moveList.append([row + 1, col + 1])
//        }
//        if ["LR", "LN", "LB", "LK", "BQ", "LP"].contains(bord[row + 1][col - 1]) && col > 7 && row < 0 {
//            moveList.append([row + 1, col + 1])
//        }
//        return moveList
//    }
    
    func LightPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row, col: col){
        
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col]) && inBord(row: row - 1, col: col){
            moveList.append([row - 1, col])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 2][col]) && inBord(row: row - 2, col: col) && row == 6 {
            moveList.append([row - 2, col])
        }
        if col != 0 && col != 7 && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col + 1]) && inBord(row: row - 1, col: col + 1){
            moveList.append([row - 1, col + 1])
        }
        if col != 0 && col != 7 && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col - 1]) && inBord(row: row - 1, col: col - 1){
            moveList.append([row - 1, col - 1])
            }
        }

        return moveList
    }
    
    func DarkPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        
        
        if ["LR", "LN", "LB", "LK", "BQ", "LP"].contains(bord[row + 1][col]) && inBord(row: row + 1, col: col){
            moveList.append([row + 1, col])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP"].contains(bord[row + 2][col]) && inBord(row: row + 2, col: col) && row == 1 {
            moveList.append([row + 2, col])
        }
        if col != 0 && col != 7 && ["LR", "LN", "LB", "LK", "BQ", "LP"].contains(bord[row + 1][col + 1]) && inBord(row: row + 1, col: col + 1){
            moveList.append([row + 1, col + 1])
        }
        if col != 0 && col != 7 && ["LR", "LN", "LB", "LK", "BQ", "LP"].contains(bord[row + 1][col - 1]) && inBord(row: row + 1, col: col - 1){
            moveList.append([row + 1, col - 1])
        }
        
        return moveList
    }
    
    func LightKing(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row][col + 1]) && inBord(row: row, col: col + 1){
            moveList.append([row, col + 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row][col - 1]) && inBord(row: row, col: col - 1){
            moveList.append([row, col - 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + 1][col]) && inBord(row: row + 1, col: col){
            moveList.append([row + 1, col])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col]) && inBord(row: row - 1, col: col){
            moveList.append([row - 1, col])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + 1][col + 1]) && inBord(row: row + 1, col: col + 1){
            moveList.append([row + 1, col + 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col - 1]) && inBord(row: row - 1, col: col - 1){
            moveList.append([row - 1, col - 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + 1][col - 1]) && inBord(row: row + 1, col: col - 1){
            moveList.append([row + 1, col - 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col + 1]) && inBord(row: row - 1, col: col + 1){
            moveList.append([row - 1, col + 1])
        }
        
        
        return moveList
    }
    
    func DarkKing(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row][col + 1]) && inBord(row: row, col: col + 1){
            moveList.append([row, col + 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row][col - 1]) && inBord(row: row, col: col - 1){
            moveList.append([row, col - 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + 1][col]) && inBord(row: row + 1, col: col){
            moveList.append([row + 1, col])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - 1][col]) && inBord(row: row - 1, col: col){
            moveList.append([row - 1, col])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + 1][col + 1]) && inBord(row: row + 1, col: col + 1){
            moveList.append([row + 1, col + 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - 1][col - 1]) && inBord(row: row - 1, col: col - 1){
            moveList.append([row - 1, col - 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + 1][col - 1]) && inBord(row: row + 1, col: col - 1){
            moveList.append([row + 1, col - 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - 1][col + 1]) && inBord(row: row - 1, col: col + 1){
            moveList.append([row - 1, col + 1])
        }
        
        
        return moveList
    }
    
    func DarkKnight(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + 1][col + 2]) && inBord(row: row + 1, col: col + 2){
            moveList.append([row + 1 , col + 2])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + 1][col - 2]) && inBord(row: row + 1, col: col - 2){
            moveList.append([row + 1, col - 2])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - 1][col + 2]) && inBord(row: row - 1, col: col + 2){
            moveList.append([row - 1, col + 2])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - 1][col - 2]) && inBord(row: row - 1, col: col - 2){
            moveList.append([row - 1, col - 2])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + 2][col + 1]) && inBord(row: row + 2, col: col + 1){
            moveList.append([row + 2, col + 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + 2][col - 1]) && inBord(row: row + 2, col: col - 1){
            moveList.append([row + 2, col - 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - 2][col + 1]) && inBord(row: row - 2, col: col + 1){
            moveList.append([row - 2, col + 1])
        }
        if ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - 2][col - 1]) && inBord(row: row - 2, col: col - 1){
            moveList.append([row - 2, col - 1])
        }
        
        
        return moveList
    }
    
    func LightKnight(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + 1][col + 2]) && inBord(row: row + 1, col: col + 2){
            moveList.append([row + 1 , col + 2])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + 1][col - 2]) && inBord(row: row + 1, col: col - 2){
            moveList.append([row + 1, col - 2])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col + 2]) && inBord(row: row - 1, col: col + 2){
            moveList.append([row - 1, col + 2])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 1][col - 2]) && inBord(row: row - 1, col: col - 2){
            moveList.append([row - 1, col - 2])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + 2][col + 1]) && inBord(row: row + 2, col: col + 1){
            moveList.append([row + 2, col + 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + 2][col - 1]) && inBord(row: row + 2, col: col - 1){
            moveList.append([row + 2, col - 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 2][col + 1]) && inBord(row: row - 2, col: col + 1){
            moveList.append([row - 2, col + 1])
        }
        if ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - 2][col - 1]) && inBord(row: row - 2, col: col - 1){
            moveList.append([row - 2, col - 1])
        }
        
        return moveList
    }
    
    func DarkBishop(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        var x = 1
        var y = 1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && ["LR", "LN", "LB", "LK", "LQ", "LP"].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = 1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && ["LR", "LN", "LB", "LK", "LQ", "LP"].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y =  1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && ["LR", "LN", "LB", "LK", "LQ", "LP"].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && ["LR", "LN", "LB", "LK", "LQ", "LP"].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        return moveList
    }
    
    
    func LightBishop(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        var x = 1
        var y = 1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = 1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x + 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y =  1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        x = -1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            moveList.append([row + x, col + y])
            x = x - 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + x][col + y]) {
                moveList.append([row + x, col + y])
            
        }
        
        return moveList
        
    }
    
    func DarkRook (bord: [[String]], row: Int, col: Int) -> [[Int]] {
           var moveList = [[Int]]()
           var x = 1
           var y = 1
           
           while inBord(row: row + x, col:col) && bord[row + x][col] == ""{
               moveList.append([row + x, col])
               x = x + 1
           }
       
           if inBord(row: row + x, col: col) && ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row + x][col]){
               moveList.append([row + x, col])
           }
           x = 1
           
           
           while inBord(row: row - x, col:col) && bord[row - x][col] == ""{
               moveList.append([row + x, col])
               x = x - 1
           }
       
           if inBord(row: row - x, col: col) && ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row - x][col]){
               moveList.append([row - x, col])
           }
           x = 1
           
           while inBord(row: row , col:col + y) && bord[row][col + y] == ""{
               moveList.append([row, col + y])
               y = y + 1
           }
       
           if inBord(row: row , col: col + y) && ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row][col + y]){
               moveList.append([row, col + y])
           }
           y = 1
           
           while inBord(row: row , col:col - y) && bord[row][col - y] == ""{
               moveList.append([row, col - y])
               y = y - 1
           }
       
           if inBord(row: row , col: col - y) && ["LR", "LN", "LB", "LK", "BQ", "LP", ""].contains(bord[row][col - y]){
               moveList.append([row, col - y])
           }
           y = 1
           
           
           return moveList
       }
    
    func LightRook (bord: [[String]], row: Int, col: Int) -> [[Int]] {
           var moveList = [[Int]]()
           var x = 1
           var y = 1
           
           while inBord(row: row + x, col:col) && bord[row + x][col] == ""{
               moveList.append([row + x, col])
               x = x + 1
           }
       
           if inBord(row: row + x, col: col) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row + x][col]){
               moveList.append([row + x, col])
           }
           x = 1
           
           
           while inBord(row: row - x, col:col) && bord[row - x][col] == ""{
               moveList.append([row + x, col])
               x = x - 1
           }
       
           if inBord(row: row - x, col: col) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row - x][col]){
               moveList.append([row - x, col])
           }
           x = 1
           
           while inBord(row: row , col:col + y) && bord[row][col + y] == ""{
               moveList.append([row, col + y])
               y = y + 1
           }
       
           if inBord(row: row , col: col + y) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row][col + y]){
               moveList.append([row, col + y])
           }
           y = 1
           
           while inBord(row: row , col:col - y) && bord[row][col - y] == ""{
               moveList.append([row, col - y])
               y = y - 1
           }
       
           if inBord(row: row , col: col - y) && ["DR", "DN", "DB", "DK", "DQ", "DP", ""].contains(bord[row][col - y]){
               moveList.append([row, col - y])
           }
           y = 1
           
           
           return moveList
       }
}
