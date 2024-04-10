//
//  GameView.swift
//  TicTacToe
//
//  Created by Ruslan Stoyanov on 07.04.2024.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameModel()

    var body: some View {
        VStack {
            Text(viewModel.turnText())
                .font(.title)
                .bold()
                .padding()

            gameBoardView()
            
            Text("Крестики: \(viewModel.crossesScore)")
                .font(.title)
                .bold()
                .padding()
            
            Text("Нолики: \(viewModel.noughtsScore)")
                .font(.title)
                .bold()
                .padding()
           
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertMessage),
                dismissButton: .default(Text("Отлично!")) {
                    viewModel.resetBoard()
                }
            )
        }
    }

    @ViewBuilder
    func gameBoardView() -> some View {
        VStack(spacing: 0.5) {
            ForEach(0..<3, id: \.self) { row in
                gameRowView(row: row, borderSize: 1)
            }
        }
    }

    @ViewBuilder
    func gameRowView(row: Int, borderSize: CGFloat) -> some View {
        HStack(spacing: 0.5) {
            ForEach(0..<3, id: \.self) { column in
                gameCellView(row: row, column: column)
            }
        }
    }

    @ViewBuilder
    func gameCellView(row: Int, column: Int) -> some View {
        let cell = viewModel.board[row][column]

        Text(cell.displayTile())
            .font(.system(size: 50))
            .bold()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(Color.black, width: 0.5)
            .aspectRatio(1, contentMode: .fit)
            .background(Color.white)
            .onTapGesture {
                viewModel.placeTile(row, column)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
