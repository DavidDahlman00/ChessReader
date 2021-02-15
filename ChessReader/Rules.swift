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
    
    func lightPawnEnPassant(bord: [[String]], checkSchack: Bool, enPassant: [Int], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if row == 3 {
            if  col - 1 >= 0 && col - 1 == enPassant[1] {
                //moveList.append([2, col - 1])
                if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: 2, colTo: col - 1) {
                    moveList.append([2, col - 1])
                }else if !checkSchack{
                    moveList.append([2, col - 1])
                }
            }
            if  col + 1 <= 7 && col + 1 == enPassant[1] {
                //moveList.append([2, col + 1])
                if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: 2, colTo: col + 1) {
                    moveList.append([2, col + 1])
                }else if !checkSchack{
                    moveList.append([2, col + 1])
                }
            }
        }
        return moveList
    }
    
    func darkPawnEnPassant(bord: [[String]], checkSchack: Bool, enPassant: [Int], row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if row == 4 {
            if  col - 1 >= 0 && col - 1 == enPassant[0]{
                //moveList.append([5, col - 1])
                if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: 5, colTo: col - 1) {
                    moveList.append([5, col - 1])
                }else if !checkSchack{
                    moveList.append([5, col - 1])
                }
            }
            if  col + 1 <= 7 && col + 1 == enPassant[0]{
                //moveList.append([5, col + 1])
                if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: 5, colTo: col + 1) {
                    moveList.append([5, col + 1])
                }else if !checkSchack{
                    moveList.append([5, col + 1])
                }
            }
        }
        return moveList
    }
    
    func lightPawn(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row - 1, col: col) && bord[row - 1][col] == "" {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col) {
                moveList.append([row - 1, col])
            }else if !checkSchack{
                moveList.append([row - 1, col])
            }
            if inBord(row: row - 2, col: col) && bord[row - 2][col] == "" && row == 6 {
                if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 2, colTo: col) {
                    moveList.append([row - 2, col])
                }else if !checkSchack{
                    moveList.append([row - 2, col])
                }
            }
        }
        if col > 0 && row > 0 && inBord(row: row - 1, col: col - 1) && darkPices.contains(bord[row - 1][col - 1]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col - 1) {
                moveList.append([row - 1, col - 1])
            }else if !checkSchack{
                moveList.append([row - 1, col - 1])
            }
        }
        if col < 7 && row > 0 && inBord(row: row - 1, col: col + 1) && darkPices.contains(bord[row - 1][col + 1]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col + 1) {
                moveList.append([row - 1, col + 1])
            }else if !checkSchack{
                moveList.append([row - 1, col + 1])
            }
        }
        return moveList
    }

    
    func darkPawn(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row + 1, col: col) && bord[row + 1][col] == ""  {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col) {
                moveList.append([row + 1, col])
            }else if !checkSchack{
                moveList.append([row + 1, col])
            }
            if inBord(row: row + 2, col: col) && bord[row + 2][col] == "" && row == 1 {
                if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 2, colTo: col) {
                    moveList.append([row + 2, col])
                }else if !checkSchack{
                    moveList.append([row + 2, col])
                }
            }
        }
        if inBord(row: row + 1, col: col - 1) && col > 0 && row > 0 && lightPices.contains(bord[row + 1][col - 1]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col - 1) {
                moveList.append([row + 1, col - 1])
            }else if !checkSchack{
                moveList.append([row + 1, col - 1])
            }
        }
        if inBord(row: row + 1, col: col + 1) && col < 7 && row > 0 && lightPices.contains(bord[row + 1][col + 1]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col + 1) {
                moveList.append([row + 1, col + 1])
            } else if !checkSchack{
                moveList.append([row + 1, col + 1])
            }
        }
        return moveList
    }
    
    func lightKing(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        
        if inBord(row: row, col: col + 1) && darkPicesAndNoPice.contains(bord[row][col + 1]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row, colTo: col + 1){
                moveList.append([row, col + 1])
            }else if !checkSchack{
                moveList.append([row, col + 1])
            }
        }
        if inBord(row: row, col: col - 1) && darkPicesAndNoPice.contains(bord[row][col - 1]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row, colTo: col - 1){
                moveList.append([row, col - 1])
            }else if !checkSchack{
                moveList.append([row, col - 1])
            }
        }
        if inBord(row: row + 1, col: col) && darkPicesAndNoPice.contains(bord[row + 1][col]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col){
                moveList.append([row + 1, col])
            }else if !checkSchack{
                moveList.append([row + 1, col])
            }
        }
        if inBord(row: row - 1, col: col) && darkPicesAndNoPice.contains(bord[row - 1][col]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col){
                moveList.append([row - 1, col])
            }else if !checkSchack{
                moveList.append([row - 1, col])
            }
        }
        if inBord(row: row + 1, col: col + 1) && darkPicesAndNoPice.contains(bord[row + 1][col + 1]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col + 1){
                moveList.append([row + 1, col + 1])
            }else if !checkSchack{
                moveList.append([row + 1, col + 1])
            }
        }
        if inBord(row: row - 1, col: col - 1) && darkPicesAndNoPice.contains(bord[row - 1][col - 1]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col - 1){
                moveList.append([row - 1, col - 1])
            }else if !checkSchack{
                moveList.append([row - 1, col - 1])
            }
        }
        if inBord(row: row + 1, col: col - 1) && darkPicesAndNoPice.contains(bord[row + 1][col - 1]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col - 1){
                moveList.append([row + 1, col - 1])
            }else if !checkSchack{
                moveList.append([row + 1, col - 1])
            }
        }
        if inBord(row: row - 1, col: col + 1) && darkPicesAndNoPice.contains(bord[row - 1][col + 1]){
            if checkSchack && !moveIsInSchachLK(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col + 1){
                moveList.append([row - 1, col + 1])
            }else if !checkSchack{
                moveList.append([row - 1, col + 1])
            }
        }
        
        
        return moveList
    }
    
    func darkKing(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row, col: col + 1) && lightPicesAndNoPice.contains(bord[row][col + 1]){
            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row, colTo: col + 1){
                moveList.append([row, col + 1])
            }else if !checkSchack{
                moveList.append([row, col + 1])
            }
            
        }
        if inBord(row: row, col: col - 1) && lightPicesAndNoPice.contains(bord[row][col - 1]){
            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row, colTo: col - 1){
                moveList.append([row, col - 1])
            }else if !checkSchack{
                moveList.append([row, col - 1])
            }
        }
        if inBord(row: row + 1, col: col) && lightPicesAndNoPice.contains(bord[row + 1][col]){
            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col){
                moveList.append([row + 1, col])
            }else if !checkSchack{
                moveList.append([row + 1, col])
            }
        }
        if inBord(row: row - 1, col: col) && lightPicesAndNoPice.contains(bord[row - 1][col]){
            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col){
                moveList.append([row - 1, col])
            }else if !checkSchack{
                moveList.append([row - 1, col])
            }
        }
        if inBord(row: row + 1, col: col + 1) && lightPicesAndNoPice.contains(bord[row + 1][col + 1]){
            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col + 1){
                moveList.append([row + 1, col + 1])
            }else if !checkSchack{
                moveList.append([row + 1, col + 1])
            }
        }
        if inBord(row: row - 1, col: col - 1) && lightPicesAndNoPice.contains(bord[row - 1][col - 1]){

            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col - 1){
                moveList.append([row - 1, col - 1])
            }else if !checkSchack{
                moveList.append([row - 1, col - 1])
            }
        }
        if inBord(row: row + 1, col: col - 1) && lightPicesAndNoPice.contains(bord[row + 1][col - 1]){
            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col - 1){
                moveList.append([row + 1, col - 1])
            }else if !checkSchack{
                moveList.append([row + 1, col - 1])
            }
        }
        if inBord(row: row - 1, col: col + 1) && lightPicesAndNoPice.contains(bord[row - 1][col + 1]){
            if checkSchack && !moveIsInSchachBK(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col + 1){
                moveList.append([row - 1, col + 1])
            }else if !checkSchack{
                moveList.append([row - 1, col + 1])
            }
        }
        
        
        return moveList
    }
    
    func darkKnight(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row + 1, col: col + 2) && lightPicesAndNoPice.contains(bord[row + 1][col + 2]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col + 2) {
                moveList.append([row + 1, col + 2])
            }else if !checkSchack{
                moveList.append([row + 1 , col + 2])
            }

        }
        if inBord(row: row + 1, col: col - 2) && lightPicesAndNoPice.contains(bord[row + 1][col - 2]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col - 2) {
                moveList.append([row + 1, col - 2])
            }else if !checkSchack{
                moveList.append([row + 1 , col - 2])
            }
        }
        if inBord(row: row - 1, col: col + 2) && lightPicesAndNoPice.contains(bord[row - 1][col + 2]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col + 2) {
                moveList.append([row - 1, col + 2])
            }else if !checkSchack{
                moveList.append([row - 1 , col + 2])
            }
        }
        if inBord(row: row - 1, col: col - 2) && lightPicesAndNoPice.contains(bord[row - 1][col - 2]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col - 2) {
                moveList.append([row - 1, col - 2])
            }else if !checkSchack{
                moveList.append([row - 1 , col - 2])
            }
        }
        if inBord(row: row + 2, col: col + 1) && lightPicesAndNoPice.contains(bord[row + 2][col + 1]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 2, colTo: col + 1) {
                moveList.append([row + 2, col + 1])
            }else if !checkSchack{
                moveList.append([row + 2 , col + 1])
            }
        }
        if inBord(row: row + 2, col: col - 1) && lightPicesAndNoPice.contains(bord[row + 2][col - 1]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + 2, colTo: col - 1) {
                moveList.append([row + 2, col - 1])
            }else if !checkSchack{
                moveList.append([row + 2 , col - 1])
            }
        }
        if inBord(row: row - 2, col: col + 1) && lightPicesAndNoPice.contains(bord[row - 2][col + 1]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - 2, colTo: col + 1) {
                moveList.append([row - 2, col + 1])
            }else if !checkSchack{
                moveList.append([row - 2 , col + 1])
            }
        }
        if inBord(row: row - 2, col: col - 1) && lightPicesAndNoPice.contains(bord[row - 2][col - 1]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - 2, colTo: col - 1) {
                moveList.append([row - 2, col - 1])
            }else if !checkSchack{
                moveList.append([row - 2 , col - 1])
            }
        }
        
        
        return moveList
    }
    
    func lightKnight(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        if inBord(row: row + 1, col: col + 2) && darkPicesAndNoPice.contains(bord[row + 1][col + 2]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col + 2) {
                moveList.append([row + 1, col + 2])
            }else if !checkSchack{
                moveList.append([row + 1 , col + 2])
            }
        }
        if inBord(row: row + 1, col: col - 2) && darkPicesAndNoPice.contains(bord[row + 1][col - 2]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + 1, colTo: col - 2) {
                moveList.append([row + 1, col - 2])
            }else if !checkSchack{
                moveList.append([row + 1 , col - 2])
            }
        }
        if inBord(row: row - 1, col: col + 2) && darkPicesAndNoPice.contains(bord[row - 1][col + 2]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col + 2) {
                moveList.append([row - 1, col + 2])
            }else if !checkSchack{
                moveList.append([row - 1 , col + 2])
            }
        }
        if inBord(row: row - 1, col: col - 2) && darkPicesAndNoPice.contains(bord[row - 1][col - 2]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 1, colTo: col - 2) {
                moveList.append([row - 1, col - 2])
            }else if !checkSchack{
                moveList.append([row - 1 , col - 2])
            }
        }
        if inBord(row: row + 2, col: col + 1) && darkPicesAndNoPice.contains(bord[row + 2][col + 1]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + 2, colTo: col + 1) {
                moveList.append([row + 2, col + 1])
            }else if !checkSchack{
                moveList.append([row + 2 , col + 1])
            }
        }
        if inBord(row: row + 2, col: col - 1) && darkPicesAndNoPice.contains(bord[row + 2][col - 1]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + 2, colTo: col - 1) {
                moveList.append([row + 2, col - 1])
            }else if !checkSchack{
                moveList.append([row + 2 , col - 1])
            }
        }
        if inBord(row: row - 2, col: col + 1) && darkPicesAndNoPice.contains(bord[row - 2][col + 1]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 2, colTo: col + 1) {
                moveList.append([row - 2, col + 1])
            }else if !checkSchack{
                moveList.append([row - 2 , col + 1])
            }
        }
        if inBord(row: row - 2, col: col - 1) && darkPicesAndNoPice.contains(bord[row - 2][col - 1]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - 2, colTo: col - 1) {
                moveList.append([row - 2, col - 1])
            }else if !checkSchack{
                moveList.append([row - 2 , col - 1])
            }
        }
        
        return moveList
    }
    
    func darkBishop(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        var x = 1
        var y = 1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
            x = x + 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        x = 1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            x = x + 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        x = -1
        y =  1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            x = x - 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        x = -1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            x = x - 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && lightPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        return moveList
    }
    
    
    func lightBishop(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
        var moveList = [[Int]]()
        var x = 1
        var y = 1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            x = x + 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        x = 1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            x = x + 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        x = -1
        y =  1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            x = x - 1
            y = y + 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        x = -1
        y = -1
        while inBord(row: row + x, col: col + y) && bord[row + x][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            x = x - 1
            y = y - 1
        }
        if inBord(row: row + x, col: col + y) && darkPices.contains(bord[row + x][col + y]) {
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col + y) {
                moveList.append([row + x, col + y])
            }else if !checkSchack{
                moveList.append([row + x, col + y])
            }
            
        }
        
        return moveList
        
    }
    
    func darkRook (bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
           var moveList = [[Int]]()
           var x = 1
           var y = 1
           
           while inBord(row: row + x, col:col) && bord[row + x][col] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col) {
                moveList.append([row + x, col])
            }else if !checkSchack{
                moveList.append([row + x, col])
            }
            
               x = x + 1
           }
       
           if inBord(row: row + x, col: col) && lightPices.contains(bord[row + x][col]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col) {
                moveList.append([row + x, col])
            }else if !checkSchack{
                moveList.append([row + x, col])
            }
           }
           x = 1
           
           
           while inBord(row: row - x, col:col) && bord[row - x][col] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - x, colTo: col) {
                moveList.append([row - x, col])
            }else if !checkSchack{
                moveList.append([row - x, col])
            }
               x = x + 1
           }
       
           if inBord(row: row - x, col: col) && lightPices.contains(bord[row - x][col]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row - x, colTo: col) {
                moveList.append([row - x, col])
            }else if !checkSchack{
                moveList.append([row - x, col])
            }
           }
           x = 1
           
           while inBord(row: row , col:col + y) && bord[row][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row, colTo: col + y) {
                moveList.append([row, col + y])
            }else if !checkSchack{
                moveList.append([row, col + y])
            }
               y = y + 1
           }
       
           if inBord(row: row , col: col + y) && lightPices.contains(bord[row][col + y]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row, colTo: col + y) {
                moveList.append([row, col + y])
            }else if !checkSchack{
                moveList.append([row, col + y])
            }
           }
           y = 1
           
           while inBord(row: row , col:col - y) && bord[row][col - y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row, colTo: col - y) {
                moveList.append([row, col - y])
            }else if !checkSchack{
                moveList.append([row, col - y])
            }
               y = y + 1
           }
       
           if inBord(row: row , col: col - y) && lightPices.contains(bord[row][col - y]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Dark", rowFrom: row, colFrom: col, rowTo: row, colTo: col - y) {
                moveList.append([row, col - y])
            }else if !checkSchack{
                moveList.append([row, col - y])
            }
           }
           y = 1
           
           
           return moveList
       }
    
    func lightRook (bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]] {
           var moveList = [[Int]]()
           var x = 1
           var y = 1
           
           while inBord(row: row + x, col:col) && bord[row + x][col] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col) {
                moveList.append([row + x, col])
            }else if !checkSchack{
                moveList.append([row + x, col])
            }
               x = x + 1
           }
       
           if inBord(row: row + x, col: col) && darkPices.contains(bord[row + x][col]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row + x, colTo: col) {
                moveList.append([row + x, col])
            }else if !checkSchack{
                moveList.append([row + x, col])
            }
           }
           x = 1
           
           
           while inBord(row: row - x, col:col) && bord[row - x][col] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - x, colTo: col) {
                moveList.append([row - x, col])
            }else if !checkSchack{
                moveList.append([row - x, col])
            }
               x = x + 1
           }
       
           if inBord(row: row - x, col: col) && darkPices.contains(bord[row - x][col]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row - x, colTo: col) {
                moveList.append([row - x, col])
            }else if !checkSchack{
                moveList.append([row - x, col])
            }
           }
           x = 1
           
           while inBord(row: row , col:col + y) && bord[row][col + y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row, colTo: col + y) {
                moveList.append([row, col + y])
            }else if !checkSchack{
                moveList.append([row, col + y])
            }
               y = y + 1
           }
       
           if inBord(row: row , col: col + y) && darkPices.contains(bord[row][col + y]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row, colTo: col + y) {
                moveList.append([row, col + y])
            }else if !checkSchack{
                moveList.append([row, col + y])
            }
           }
           y = 1
           
           while inBord(row: row , col:col - y) && bord[row][col - y] == ""{
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row, colTo: col - y) {
                moveList.append([row, col - y])
            }else if !checkSchack{
                moveList.append([row, col - y])
            }
               y = y + 1
           }
       
           if inBord(row: row , col: col - y) && darkPices.contains(bord[row][col - y]){
            if checkSchack && !moveIsInSchach(bord: bord, player: "Light", rowFrom: row, colFrom: col, rowTo: row, colTo: col - y) {
                moveList.append([row, col - y])
            }else if !checkSchack{
                moveList.append([row, col - y])
            }
           }
           y = 1
           
           
           return moveList
       }
    
    func darkQueen(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]]{
        return darkBishop(bord: bord, checkSchack: checkSchack, row: row, col: col) +  darkRook(bord: bord, checkSchack: checkSchack, row: row, col: col)
    }
    
    func lightQueen(bord: [[String]], checkSchack: Bool, row: Int, col: Int) -> [[Int]]{
        return lightBishop(bord: bord, checkSchack: checkSchack, row: row, col: col) +  lightRook(bord: bord, checkSchack: checkSchack, row: row, col: col)
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
    
    func shortCastling(bord: Bord) -> Bool {
        if bord.playerToGo == "Light" && !bord.kingHasMoved[0] && bord.bord[7][7] == "LR" &&
            bord.bord[7][5] == "" && bord.bord[7][6] == "" && !bord.schach[0]{
            var tmpBord1 = bord.bord
            tmpBord1[7][4] = ""
            tmpBord1[7][5] = "LK"
            var tmpBord2 = bord.bord
            tmpBord2[7][4] = ""
            tmpBord2[7][6] = "LK"
            if !checkForSchach(bord: tmpBord1, player: "Light") && !checkForSchach(bord: tmpBord2, player: "Light") {
                return true
            }
        } else if !bord.kingHasMoved[1] && bord.bord[0][7] == "BR" &&
                    bord.bord[0][5] == "" && bord.bord[0][6] == "" && !bord.schach[1]{
            var tmpBord1 = bord.bord
            tmpBord1[0][4] = ""
            tmpBord1[0][5] = "BK"
            var tmpBord2 = bord.bord
            tmpBord2[0][4] = ""
            tmpBord2[0][6] = "BK"
            if !checkForSchach(bord: tmpBord1, player: "Dark") && !checkForSchach(bord: tmpBord2, player: "Dark") {
                return true
            }
        }
        return false
    }
    
    func longCastling(bord: Bord) -> Bool {
        if bord.playerToGo == "Light" && !bord.kingHasMoved[0] && bord.bord[7][0] == "LR" &&
            bord.bord[7][1] == "" && bord.bord[7][2] == "" && bord.bord[7][3] == "" && !bord.schach[0]{
            var tmpBord1 = bord.bord
            tmpBord1[7][4] = ""
            tmpBord1[7][3] = "LK"
            var tmpBord2 = bord.bord
            tmpBord2[7][4] = ""
            tmpBord2[7][2] = "LK"
            if !checkForSchach(bord: tmpBord1, player: "Light") && !checkForSchach(bord: tmpBord2, player: "Light") {
                return true
            }
        } else if !bord.kingHasMoved[1] && bord.bord[0][0] == "BR" &&
                    bord.bord[0][1] == "" && bord.bord[0][2] == "" && bord.bord[0][3] == "" && !bord.schach[1]{
            var tmpBord1 = bord.bord
            tmpBord1[0][4] = ""
            tmpBord1[0][3] = "BK"
            var tmpBord2 = bord.bord
            tmpBord2[0][4] = ""
            tmpBord2[0][2] = "BK"
            if !checkForSchach(bord: tmpBord1, player: "Dark") && !checkForSchach(bord: tmpBord2, player: "Dark") {
                return true
            }
        }
        return false
    }
    
    func SchackMate(bord: [[String]], enPassant: [Int], player: String) -> Bool {
        print("test checkMate")
        if checkForSchach(bord: bord, player: player){
            var moveList = [[Int]]()
            var pieces: [String]
            var error = false
            if player == "Light"{
                pieces = lightPices
            }else{
                pieces = darkPices
            }
            for piece in pieces{
                if !getPiecesPositions(bord: bord, piece: piece).isEmpty{
                    for position in getPiecesPositions(bord: bord, piece: piece) {
                        switch piece {
                        case "DB":
                            moveList = moveList + darkBishop(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LB":
                            moveList = moveList + lightBishop(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DK":
                            moveList = moveList + darkKing(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LK":
                            moveList = moveList + lightKing(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DN":
                            moveList = moveList + darkKnight(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LN":
                            moveList = moveList + lightKnight(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DP":
                            moveList = moveList + darkPawn(bord: bord, checkSchack: true, row: position[0], col: position[1])
                            moveList = moveList + darkPawnEnPassant(bord: bord, checkSchack: true, enPassant: enPassant, row: position[0], col: position[1])
                        case "LP":
                            moveList = moveList + lightPawn(bord: bord, checkSchack: true, row: position[0], col: position[1])
                            moveList = moveList + lightPawnEnPassant(bord: bord, checkSchack: true, enPassant: enPassant, row: position[0], col: position[1])
                        case "DQ":
                            moveList = moveList + darkQueen(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LQ":
                            moveList = moveList + lightQueen(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DR":
                            moveList = moveList + darkRook(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LR":
                            moveList = moveList + lightRook(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        default:
                            error = true
                            
                        }
                    }
                }
            }
            print(moveList)
            if moveList.isEmpty{
                return true
            }
        }
        return false
    }
    
    func StaleMate(bord: [[String]], enPassant: [Int], player: String) -> Bool {
        print("test checkMate")
        if !checkForSchach(bord: bord, player: player){
            var moveList = [[Int]]()
            var pieces: [String]
            var error = false
            if player == "Light"{
                pieces = lightPices
            }else{
                pieces = darkPices
            }
            for piece in pieces{
                if !getPiecesPositions(bord: bord, piece: piece).isEmpty{
                    for position in getPiecesPositions(bord: bord, piece: piece) {
                        switch piece {
                        case "DB":
                            moveList = moveList + darkBishop(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LB":
                            moveList = moveList + lightBishop(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DK":
                            moveList = moveList + darkKing(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LK":
                            moveList = moveList + lightKing(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DN":
                            moveList = moveList + darkKnight(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LN":
                            moveList = moveList + lightKnight(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DP":
                            moveList = moveList + darkPawn(bord: bord, checkSchack: true, row: position[0], col: position[1])
                            moveList = moveList + darkPawnEnPassant(bord: bord, checkSchack: true, enPassant: enPassant, row: position[0], col: position[1])
                        case "LP":
                            moveList = moveList + lightPawn(bord: bord, checkSchack: true, row: position[0], col: position[1])
                            moveList = moveList + lightPawnEnPassant(bord: bord, checkSchack: true, enPassant: enPassant, row: position[0], col: position[1])
                        case "DQ":
                            moveList = moveList + darkQueen(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LQ":
                            moveList = moveList + lightQueen(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "DR":
                            moveList = moveList + darkRook(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        case "LR":
                            moveList = moveList + lightRook(bord: bord, checkSchack: true, row: position[0], col: position[1])
                        default:
                            error = true
                            
                        }
                    }
                }
            }
            print(moveList)
            if moveList.isEmpty{
                return true
            }
        }
        return false
    }
    
    func checkForSchach(bord: [[String]], player: String) -> Bool  {
        let kingPosition: [Int]
       
        if player == "Light" {
             kingPosition = getPiecesPositions(bord: bord, piece: "LK")[0]
        }else{
             kingPosition = getPiecesPositions(bord: bord, piece: "BK")[0]
        }
        print("king position \(kingPosition[0]), \(kingPosition[1])")
        var moveList = [[Int]]()
        
        if player == "Light" {
            for value in darkPices{
                let pieces = getPiecesPositions(bord: bord, piece: value)
                for piece in pieces{
                    switch value {
                    case "BB":
                        moveList = moveList + darkBishop(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "BK":
                        moveList = moveList + darkKing(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "BN":
                        moveList = moveList + darkKnight(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "BP":
                        moveList = moveList + darkPawn(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "BR":
                        moveList = moveList + darkRook(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "BQ":
                        moveList = moveList + darkQueen(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    default: break
                    }
                }
                print("in light move")
            }
        }else {
            for value in lightPices{
                let pieces = getPiecesPositions(bord: bord, piece: value)
                for piece in pieces{
                    switch value {
                    case "LB":
                        moveList = moveList + lightBishop(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "LK":
                        moveList = moveList + lightKing(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "LN":
                        moveList = moveList + lightKnight(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "LP":
                        moveList = moveList + lightPawn(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "LR":
                        moveList = moveList + lightRook(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    case "LQ":
                        moveList = moveList + lightQueen(bord: bord, checkSchack: false, row: piece[0], col: piece[1])
                    default: break
                    }
                }
            }
            print("in dark move")
        }
        if moveList.contains(kingPosition) {
            return true
        }
        return false
    }
    
    func moveIsInSchach(bord: [[String]],player: String, rowFrom: Int, colFrom: Int, rowTo: Int, colTo: Int) -> Bool {
        
        var tmpBord = bord
        tmpBord[rowFrom][colFrom] = ""
        tmpBord[rowTo][colTo] = "?"
        return checkForSchach(bord: tmpBord, player: player)
    }
    
    func moveIsInSchachLK(bord: [[String]],player: String, rowFrom: Int, colFrom: Int, rowTo: Int, colTo: Int) -> Bool {
        
        var tmpBord = bord
        tmpBord[rowFrom][colFrom] = ""
        tmpBord[rowTo][colTo] = "LK"
        return checkForSchach(bord: tmpBord, player: player)
    }
    
    func moveIsInSchachBK(bord: [[String]],player: String, rowFrom: Int, colFrom: Int, rowTo: Int, colTo: Int) -> Bool {
        
        var tmpBord = bord
        tmpBord[rowFrom][colFrom] = ""
        tmpBord[rowTo][colTo] = "BK"
        return checkForSchach(bord: tmpBord, player: player)
    }
}
