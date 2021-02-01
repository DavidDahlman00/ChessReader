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
    
    func LightPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if bord[row][col] == "LP" {
            if bord[row - 1][col] == "" && row > 0  {
                moveList.append([row - 1, col,])
                if bord[row - 2][col] == "" && row == 6 {
                    moveList.append([row - 2, col,])
                }
            }
            if ["DR", "DN", "DB", "DK", "DQ", "DP"].contains(bord[row - 1][col - 1]) && col > 0 && row > 0 {
                moveList.append([row - 1, col - 1])
            }
            if ["DR", "DN", "DB", "DK", "DQ", "DP"].contains(bord[row - 1][col + 1]) && col < 7 && row > 0 {
                moveList.append([row - 1, col - 1])
            }
        }
        return moveList
    }
    
    func DarkPawn(bord: [[String]], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if bord[row + 1][col] == "" && row < 0  {
            moveList.append([row + 1, col,])
            if bord[row + 2][col] == "" && row == 1 {
                moveList.append([row + 2, col,])
            }
        }
        if ["LR", "LN", "LB", "LK", "LQ", "LP"].contains(bord[row + 1][col + 1]) && col < 0 && row < 0 {
            moveList.append([row + 1, col + 1])
        }
        if ["LR", "LN", "LB", "LK", "LQ", "LP"].contains(bord[row + 1][col - 1]) && col > 7 && row < 0 {
            moveList.append([row + 1, col + 1])
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
    
    
}
