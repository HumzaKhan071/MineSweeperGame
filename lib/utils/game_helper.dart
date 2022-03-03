import 'dart:math';

import 'package:flutter/material.dart';

class MineSweeperGame {
  static int row = 6;
  static int col = 6;
  static int cell = row * col;
  bool gameOver = false;
  List<Cell> gameMap = [];
  static List<List<dynamic>> map = List.generate(
      row, (x) => List.generate(col, (y) => Cell(x, y, "", false)));

//Create a function to generate a Map
  void generateMap() {
    PlaceMines(10);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        gameMap.add(map[i][j]);
      }
    }
  }

  //Create a function to reset the Game
  void resetGame() {
    map = List.generate(
        row, (x) => List.generate(col, (y) => Cell(x, y, "", false)));

    gameMap.clear();
    generateMap();
  }

//Create a function to place mines randomly
  static void PlaceMines(int minesNumber) {
    Random random = new Random();
    for (int i = 0; i < minesNumber; i++) {
      int mineRow = random.nextInt(row);
      int mineCol = random.nextInt(col);

      map[mineRow][mineCol] = Cell(mineRow, mineCol, "X", false);
    }
  }

  //function to show all the hidden mines if we lose

  void showMines() {
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        if (map[i][j].content == "X") {
          map[i][j].reveal = true;
        }
      }
    }
  }

// Function to get what actions to do then we click a cell

  void getClickedCell(Cell cell) {
    //check if we clicked mine
    if (cell.content == "X") {
      showMines();
      gameOver = true;
    } else {
      //calculate the number to display near mines
      int MineCount = 0;
      int cellRow = cell.row;
      int cellColumn = cell.col;

      for (int i = max(cellRow - 1, 0); i <= min(cellRow + 1, 0); i++) {
        //here we will get all the cell around the clicked cell and everytime there is a mine around it will increment the counter
        for (int j = max(cellColumn - 1, 0); j <= min(cellColumn + 1, 0); j++) {
          if (map[i][j].content == "X") {
            MineCount++;
          }
        }
      }

      cell.content = MineCount;
      cell.reveal = true;
      if (MineCount == 0) {
        // we will reveal all the adjacent cells untill we get a number
        for (int i = max(cellRow - 1, 0); i <= min(cellRow + 1, row - 1); i++) {
          for (int j = max(cellColumn - 1, 0);
              j <= min(cellColumn + 1, col - 1);
              j++) {
            if (map[i][j].content == "") {
              //we will recursive the function

              getClickedCell(map[i][j]);
            }
          }
        }
      }
    }
  }
}

class Cell {
  int row;
  int col;
  dynamic content;
  bool reveal = false;
  Cell(this.row, this.col, this.content, this.reveal);
}
