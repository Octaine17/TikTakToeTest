//
//  GameModel.swift
//  TicTacToe
//
//  Created by Ruslan Stoyanov on 07.04.2024.
//

import Foundation

class GameModel: ObservableObject {
    
    @Published var board = [[GameCell]]()
    @Published var turn = Title.crossTitle
    @Published var noughtsScore = 0
    @Published var crossesScore = 0
    @Published var showAlert = false
    @Published var alertMessage = String()
    
    init() {
        resetBoard()
    }
    
    func turnText() -> String {
        return "Ходят: \(turn.rawValue)"
    }
    
    func placeTile(_ row: Int, _ column: Int) {
        guard board[row][column].title == .emptyTitle else { return }
        
        board[row][column].title = turn
        
        if checkForVictory() {
            if turn == .crossTitle {
                crossesScore += 1
            } else {
                noughtsScore += 1
            }
            let winner = turn == .crossTitle ? "Крестики" : "Нолики"
            alertMessage = "\(winner) Выиграли!"
            showAlert = true
        } else {
            turn = turn == .crossTitle ? .noughtTitle : .crossTitle
        }
        
        if checkForDraw() {
            alertMessage = "Ничья!"
            showAlert = true
        }
    }
    
    func checkForDraw() -> Bool {
        return board.allSatisfy { $0.allSatisfy { $0.title != .emptyTitle } }
    }
    
    func checkForVictory() -> Bool {
        for i in 0..<3 {
            if isTurnTile(i, 0) && isTurnTile(i, 1) && isTurnTile(i, 2) {
                return true
            }
            if isTurnTile(0, i) && isTurnTile(1, i) && isTurnTile(2, i) {
                return true
            }
        }
        
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2) {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0) {
            return true
        }
        
        return false
    }
    
    func isTurnTile(_ row: Int, _ column: Int) -> Bool {
        return board[row][column].title == turn
    }
    
    func resetBoard() {
        board = Array(repeating: Array(repeating: GameCell(title: .emptyTitle), count: 3), count: 3)
    }
}
