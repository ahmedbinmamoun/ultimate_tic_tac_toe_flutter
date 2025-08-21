import 'package:flutter/material.dart';
import 'package:ultimate_tic_tac_toe_flutter/models/board_model.dart';
import 'package:ultimate_tic_tac_toe_flutter/models/player_model.dart';
import 'dart:async';
import 'dart:math';

import 'package:ultimate_tic_tac_toe_flutter/screens/home_screen.dart';

class GameScreen extends StatefulWidget {
  static String routName = '/game';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  final BoardModel board = BoardModel();
  PlayerModel currentPlayer = PlayerModel(symbol: 'X');
  late AnimationController _controller;
  late Map arguments;

  int player1Score = 0;
  int player2Score = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetBoard() {
    setState(() {
      board.cells = List.generate(9, (_) => List.filled(9, null));
      board.miniBoardWinners = List.generate(3, (_) => List.filled(3, null));
    });
  }

  void _handleTap(int cellRow, int cellCol) {
    if (board.cells[cellRow][cellCol] == null) {
      setState(() {
        board.makeMove(cellRow, cellCol, currentPlayer.symbol);
        if (board.checkMiniBoardWin(cellRow ~/ 3, cellCol ~/ 3, currentPlayer.symbol)) {
          _animateSmallBoardWin(cellRow ~/ 3, cellCol ~/ 3, currentPlayer.symbol);
        }
        if (board.checkBigBoardWin(currentPlayer.symbol)) {
          _animateBigBoardWin(currentPlayer.symbol);
        }
        currentPlayer = currentPlayer.symbol == 'X'
            ? PlayerModel(symbol: 'O')
            : PlayerModel(symbol: 'X');

        if (arguments['mode'] == 'computer' && currentPlayer.symbol == 'O') {
          _playComputerMove(arguments['level']);
        }
      });
    }
  }

  void _playComputerMove(String level) {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        List<List<int>> availableMoves = [];
        for (int i = 0; i < 9; i++) {
          for (int j = 0; j < 9; j++) {
            if (board.cells[i][j] == null) {
              availableMoves.add([i, j]);
            }
          }
        }

        if (availableMoves.isNotEmpty) {
          List<int> move;
          if (level == 'easy') {
            move = availableMoves[Random().nextInt(availableMoves.length)];
          } else if (level == 'medium') {
            move = _findMediumMove(availableMoves);
          } else {
            move = _findHardMove(availableMoves);
          }

          board.makeMove(move[0], move[1], currentPlayer.symbol);
          if (board.checkMiniBoardWin(move[0] ~/ 3, move[1] ~/ 3, currentPlayer.symbol)) {
            _animateSmallBoardWin(move[0] ~/ 3, move[1] ~/ 3, currentPlayer.symbol);
          }
          if (board.checkBigBoardWin(currentPlayer.symbol)) {
            _animateBigBoardWin(currentPlayer.symbol);
          }
          currentPlayer = PlayerModel(symbol: 'X');
        }
      });
    });
  }

  List<int> _findMediumMove(List<List<int>> availableMoves) {
    // Implement medium-level logic here (e.g., block opponent's winning move)
    return availableMoves[Random().nextInt(availableMoves.length)];
  }

  List<int> _findHardMove(List<List<int>> availableMoves) {
    // Implement hard-level logic to prioritize winning moves or block opponent's winning moves
    for (var move in availableMoves) {
      // Simulate the move for the computer
      board.cells[move[0]][move[1]] = currentPlayer.symbol;
      if (board.checkBigBoardWin(currentPlayer.symbol)) {
        board.cells[move[0]][move[1]] = null; // Undo the move
        return move;
      }
      board.cells[move[0]][move[1]] = null; // Undo the move
    }

    for (var move in availableMoves) {
      // Simulate the move for the opponent
      board.cells[move[0]][move[1]] = currentPlayer.symbol == 'X' ? 'O' : 'X';
      if (board.checkBigBoardWin(currentPlayer.symbol == 'X' ? 'O' : 'X')) {
        board.cells[move[0]][move[1]] = null; // Undo the move
        return move;
      }
      board.cells[move[0]][move[1]] = null; // Undo the move
    }

    // If no winning or blocking move, pick a random move
    return availableMoves[Random().nextInt(availableMoves.length)];
  }

  void _animateSmallBoardWin(int miniRow, int miniCol, String symbol) {
    _controller.forward(from: 0).then((_) {
      setState(() {
        board.miniBoardWinners[miniRow][miniCol] = symbol;
        for (int i = miniRow * 3; i < miniRow * 3 + 3; i++) {
          for (int j = miniCol * 3; j < miniCol * 3 + 3; j++) {
            board.cells[i][j] = symbol;
          }
        }
      });
    });
  }

  void _showWinDialog(String winner) {
    if (winner == 'Player 1') {
      player1Score++;
    } else {
      player2Score++;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$winner Wins!'),
          content: Text('Congratulations!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resetBoard();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _animateBigBoardWin(String symbol) {
    _controller.forward(from: 0).then((_) {
      setState(() {
        for (int i = 0; i < 9; i++) {
          for (int j = 0; j < 9; j++) {
            board.cells[i][j] = symbol;
          }
        }
      });
      _showWinDialog(symbol == 'X' ? 'Player 1' : 'Player 2');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ultimate Tic Tac Toe'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Player 1: X', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Player 2: O', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Score: $player1Score - $player2Score', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 9,
              itemBuilder: (context, bigIndex) {
                int bigRow = bigIndex ~/ 3;
                int bigCol = bigIndex % 3;

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: board.miniBoardWinners[bigRow][bigCol] == 'X'
                        ? Colors.blue.withOpacity(0.3)
                        : board.miniBoardWinners[bigRow][bigCol] == 'O'
                            ? Colors.red.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.1),
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, smallIndex) {
                      int smallRow = smallIndex ~/ 3;
                      int smallCol = smallIndex % 3;
                      int cellRow = bigRow * 3 + smallRow;
                      int cellCol = bigCol * 3 + smallCol;

                      return GestureDetector(
                        onTap: () => _handleTap(cellRow, cellCol),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: board.cells[cellRow][cellCol] == null
                                ? null
                                : Image.asset(
                                    board.cells[cellRow][cellCol] == 'X'
                                        ? 'assets/images/x.png'
                                        : 'assets/images/o.png',
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}