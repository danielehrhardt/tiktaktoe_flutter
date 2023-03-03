import 'package:flutter/material.dart';

void main() {
  runApp(TikTakToe());
}

class TikTakToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTakToe',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 230, 234, 235),
        appBar: AppBar(
          title: Text('TikTakToe'),
          backgroundColor: Color.fromARGB(255, 31, 53, 84),
        ),
        body: Center(
          child: TikTakToeBoard(),
        ),
      ),
    );
  }
}

class TikTakToeBoard extends StatefulWidget {
  @override
  _TikTakToeBoardState createState() => _TikTakToeBoardState();
}

class _TikTakToeBoardState extends State<TikTakToeBoard> {
  List<List<String>> board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String currentPlayer = 'X';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTile(0, 0),
            _buildTile(0, 1),
            _buildTile(0, 2),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTile(1, 0),
            _buildTile(1, 1),
            _buildTile(1, 2),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTile(2, 0),
            _buildTile(2, 1),
            _buildTile(2, 2),
          ],
        ),
      ],
    );
  }

  Widget _buildTile(int row, int col) {
    return GestureDetector(
      onTap: () {
        if (board[row][col] == '') {
          setState(() {
            board[row][col] = currentPlayer;
            if (_checkWinner(row, col)) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Winner!'),
                    content: Text('Player $currentPlayer has won!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resetGame();
                        },
                        child: Text('Play Again'),
                      ),
                    ],
                  );
                },
              );
            } else if (_checkTie()) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Tie!'),
                    content: Text('The game has ended in a tie.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resetGame();
                        },
                        child: Text('Play Again'),
                      ),
                    ],
                  );
                },
              );
            } else {
              currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
            }
          });
        }
      },
      child: Container(
        width: 75.0,
        height: 75.0,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 31, 53, 84)),
        ),
        child: Center(
          child: Text(
            board[row][col],
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );
  }

  bool _checkWinner(int row, int col) {
    //
    // Check row
    if (board[row][0] == currentPlayer &&
        board[row][1] == currentPlayer &&
        board[row][2] == currentPlayer) {
      return true;
    }
// Check column
    if (board[0][col] == currentPlayer &&
        board[1][col] == currentPlayer &&
        board[2][col] == currentPlayer) {
      return true;
    }
// Check diagonal
    if (row == col &&
        board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      return true;
    }
// Check anti-diagonal
    if (row + col == 2 &&
        board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      return true;
    }
    return false;
  }

  bool _checkTie() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  void _resetGame() {
    setState(() {
      board = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
      currentPlayer = 'X';
    });
  }
}
