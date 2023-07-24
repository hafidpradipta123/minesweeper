import 'package:flutter/material.dart';
import 'package:minesweeper/numberbox.dart';

import 'bomb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 9 * 9;
  int numberInEachRow = 9;
  var squareStatus = [];
  final List<int> bombLocation = [2, 4, 5, 7, 10, 61, 80];
  bool bombsRevealed = false;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

  void revealBoxNumbers(int index) {
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    } else if (squareStatus[index][0] == 0) {
      setState(() {
        squareStatus[index][1] = true;
        //left
        if (index % numberInEachRow != 0) {
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }
          squareStatus[index - 1][1] = true;
        }
//topleft
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          if (squareStatus[index - 1 - numberInEachRow][0] == 0 &&
              squareStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 - numberInEachRow);
          }
          squareStatus[index - 1][1] = true;
        }
//top
        if (index >= numberInEachRow) {
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxNumbers(index - numberInEachRow);
          }
          squareStatus[index - numberInEachRow][1] = true;
        }

        //topright
        if (index >= numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          if (squareStatus[index + 1 - numberInEachRow][0] == 0 &&
              squareStatus[index + 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 - numberInEachRow);
          }
          squareStatus[index + 1 - numberInEachRow][1] = true;
        }
//right
        if (index % numberInEachRow != numberInEachRow - 1) {
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }
          squareStatus[index + 1][1] = true;
        }

//bottom right
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 + numberInEachRow);
          }
          squareStatus[index + 1 + numberInEachRow][1] = true;
        }

        //bottom
        if (index < numberOfSquares - numberInEachRow) {
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxNumbers(index + numberInEachRow);
          }
          squareStatus[index + numberInEachRow][1] = true;
        }

        //bottom left
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != 0) {
          if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
              squareStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 + numberInEachRow);
          }
          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      int numberOfBombsAround = 0;
      //left
      if (bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

//topleft
      if (bombLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      //top

      if (bombLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      //topright

      if (bombLocation.contains(i + 1 - numberInEachRow) &&
          i >= numberInEachRow &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }

      if (bombLocation.contains(i + 1) &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }
      if (bombLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      if (bombLocation.contains(i + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      if (bombLocation.contains(i - 1 + numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '6',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(" B O M B ")
                ],
              ),
              Card(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 40,
                ),
                color: Colors.grey[700],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('0', style: TextStyle(fontSize: 40)),
                  Text("T I M E")
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: numberOfSquares,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberInEachRow),
              itemBuilder: (context, index) {
                if (bombLocation.contains(index)) {
                  return MyBomb(
                    revealed: bombsRevealed,
                    function: () {
                      setState(() {
                        bombsRevealed = true;
                      });
                      //lost
                    },
                  );
                } else {
                  return MyNumberBox(
                    child: squareStatus[index][0],
                    revealed: squareStatus[index][1],
                    function: () {
                      //reveal
                      revealBoxNumbers(index);
                    },
                  );
                }
              }),
        )
      ]),
    );
  }
}
