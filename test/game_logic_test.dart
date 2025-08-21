import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_tic_tac_toe_flutter/models/board_model.dart';
import 'package:ultimate_tic_tac_toe_flutter/models/player_model.dart';

void main() {
  group('Game Logic Tests', () {
    late BoardModel board;
    late PlayerModel playerX;
    late PlayerModel playerO;

    setUp(() {
      playerX = PlayerModel(symbol: 'X');
      playerO = PlayerModel(symbol: 'O');
      board = BoardModel();
    });

    test('Initial board should be empty', () {
      expect(board.isBoardEmpty(), true);
    });

    test('Player X should be able to make a move', () {
      board.makeMove(0, 0, playerX.symbol);
      expect(board.cells[0][0], playerX.symbol);
    });

    test('Player O should be able to make a move', () {
      board.makeMove(1, 1, playerO.symbol);
      expect(board.cells[1][1], playerO.symbol);
    });

    test('Winning condition for Player X', () {
      board.makeMove(0, 0, playerX.symbol);
      board.makeMove(0, 1, playerX.symbol);
      board.makeMove(0, 2, playerX.symbol);
      expect(board.checkWin(playerX.symbol), true);
    });

    test('Winning condition for Player O', () {
      board.makeMove(1, 0, playerO.symbol);
      board.makeMove(1, 1, playerO.symbol);
      board.makeMove(1, 2, playerO.symbol);
      expect(board.checkWin(playerO.symbol), true);
    });

    test('Game should not allow move in already occupied cell', () {
      board.makeMove(2, 2, playerX.symbol);
      expect(() => board.makeMove(2, 2, playerO.symbol), throwsA(isA<Exception>()));
    });

    test('Game should detect a draw', () {
      // Fill the board without winning
      board.makeMove(0, 0, playerX.symbol);
      board.makeMove(0, 1, playerO.symbol);
      board.makeMove(0, 2, playerX.symbol);
      board.makeMove(1, 0, playerO.symbol);
      board.makeMove(1, 1, playerX.symbol);
      board.makeMove(1, 2, playerO.symbol);
      board.makeMove(2, 0, playerO.symbol);
      board.makeMove(2, 1, playerX.symbol);
      board.makeMove(2, 2, playerO.symbol);
      expect(board.checkDraw(), true);
    });
  });
}