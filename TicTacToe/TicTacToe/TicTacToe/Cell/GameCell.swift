//
//  GameCell.swift
//  TicTacToe
//
//  Created by Ruslan Stoyanov on 07.04.2024.
//

import Foundation

enum Title: String {
    case emptyTitle = ""
    case crossTitle = "X"
    case noughtTitle = "O"
}

struct GameCell {
    var title: Title
    
    func displayTile() -> String {
        switch title {
        case .noughtTitle:
            return "O"
        case .crossTitle:
            return "X"
        default:
            return ""
        }
    }
}
