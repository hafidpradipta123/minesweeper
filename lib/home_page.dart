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
  final List<int> bombLocation = [
    2,
    4,

  
  ];
  bool bombsRevealed = false;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

void restartGame(){
  setState(() {
    bombsRevealed = false;
    for(int i = 0; i< numberOfSquares; i++){
      squareStatus[i][1]= false;
    }

  });
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

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: const Center(
                child: Text(
              "YOU LOST",
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: (){
                restartGame();
                Navigator.pop(context);

              },
              child: Icon(Icons.refresh),)
            ],
          );
        });
  }


void playerWon(){
   showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: const Center(
                child: Text(
              "YOU WIN",
              style: TextStyle(color: Colors.green),
            )),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: Icon(Icons.refresh),
              )
            ],
          );
        });

}

void checkWinner(){
  int unrevealedBoxes = 0;
  for (int i = 0; i< numberOfSquares; i++){
    if (squareStatus[i][1] == false) {
      unrevealedBoxes++;
    };
  }

  if(unrevealedBoxes == bombLocation.length){
    playerWon();
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bombLocation.length.toString(),
                    style: const TextStyle(fontSize: 40),
                  ),
                  const Text(" B O M B ")
                ],
              ),
              GestureDetector(
                onTap: restartGame,
                child: Card(
                  child:const  Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 40,
                  ),
                  color: Colors.grey[700],
                ),
              ),
              const Column(
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
                      playerLost();
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
                      checkWinner();
                    },
                  );
                }
              }),
        )
      ]),
    );
  }
}
