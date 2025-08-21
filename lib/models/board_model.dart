class BoardModel {
  List<List<String?>> cells;
  List<List<String?>> miniBoardWinners;

  BoardModel()
      : cells = List.generate(9, (_) => List.filled(9, null)),
        miniBoardWinners = List.generate(3, (_) => List.filled(3, null));

  bool isMiniBoardEmpty(int miniRow, int miniCol) {
    int startRow = miniRow * 3;
    int startCol = miniCol * 3;
    for (int i = startRow; i < startRow + 3; i++) {
      for (int j = startCol; j < startCol + 3; j++) {
        if (cells[i][j] != null) {
          return false;
        }
      }
    }
    return true;
  }

  void makeMove(int row, int col, String symbol) {
    if (cells[row][col] != null) {
      throw Exception('Cell is already occupied');
    }
    cells[row][col] = symbol;

    int miniRow = row ~/ 3;
    int miniCol = col ~/ 3;
    if (checkMiniBoardWin(miniRow, miniCol, symbol)) {
      miniBoardWinners[miniRow][miniCol] = symbol;
    }
  }

  bool checkMiniBoardWin(int miniRow, int miniCol, String symbol) {
    int startRow = miniRow * 3;
    int startCol = miniCol * 3;

    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (cells[startRow + i].sublist(startCol, startCol + 3).every((cell) => cell == symbol) ||
          [0, 1, 2].every((j) => cells[startRow + j][startCol + i] == symbol)) {
        return true;
      }
    }

    // Check diagonals
    if ((cells[startRow][startCol] == symbol &&
            cells[startRow + 1][startCol + 1] == symbol &&
            cells[startRow + 2][startCol + 2] == symbol) ||
        (cells[startRow][startCol + 2] == symbol &&
            cells[startRow + 1][startCol + 1] == symbol &&
            cells[startRow + 2][startCol] == symbol)) {
      return true;
    }

    return false;
  }

  bool checkBigBoardWin(String symbol) {
    // Check rows and columns for the big board
    for (int i = 0; i < 3; i++) {
      if (miniBoardWinners[i].every((cell) => cell == symbol) ||
          [0, 1, 2].every((j) => miniBoardWinners[j][i] == symbol)) {
        return true;
      }
    }

    // Check diagonals for the big board
    if ((miniBoardWinners[0][0] == symbol &&
            miniBoardWinners[1][1] == symbol &&
            miniBoardWinners[2][2] == symbol) ||
        (miniBoardWinners[0][2] == symbol &&
            miniBoardWinners[1][1] == symbol &&
            miniBoardWinners[2][0] == symbol)) {
      return true;
    }

    return false;
  }

  bool checkDraw() {
    return cells.every((row) => row.every((cell) => cell != null)) &&
        !checkBigBoardWin('X') &&
        !checkBigBoardWin('O');
  }

  bool isBoardEmpty() {
    return cells.every((row) => row.every((cell) => cell == null));
  }

  bool checkWin(String symbol) {
    return checkBigBoardWin(symbol);
  }
}