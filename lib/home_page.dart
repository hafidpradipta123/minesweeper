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
  final List<int> bombLocation = [2, 4, 5, 7, 10];

  @override
  void initState() {
    super.initState();
    scanBombs();
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
  }

  void revealBoxNumbers(int index) {
    setState(() {
      squareStatus[index][1] = true;
    });
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      int numberOfBombsAround = 0;
      //left
      if (bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      if(bombLocation.contains(i-1-numberInEachRow ) && i % numberInEachRow != 0 && i>= numberInEachRow){
        numberOfBombsAround++;
      }
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: numberOfSquares,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberInEachRow),
              itemBuilder: (context, index) {
                if (bombLocation.contains(index)) {
                  return MyBomb(
                    child: index,
                    revealed: squareStatus[index][1],
                    function: () {
                      //lost
                    },
                  );
                } else {
                  return MyNumberBox(
                    child: index % numberInEachRow,
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
