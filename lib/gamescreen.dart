import 'package:flutter/material.dart';
import 'package:flutter_app/color/styles.dart';
import 'package:flutter_app/logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = 'X';
  bool GameOver = false;
  int turn = 0;
  String result = '';
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _HeaderText(),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardCount ~/ 3,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                Game.boardCount,
                (index) {
                  return InkWell(
                    onTap: GameOver
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn++;
                                GameOver = game.winnerCheck(
                                    lastValue, index, scoreboard, 3);
                                if (GameOver) {
                                  result = "$lastValue is the winner";
                                } else if (!GameOver && turn == 9) {
                                  result = "It's Draw";
                                  GameOver = true;
                                }
                                if (lastValue == 'X')
                                  lastValue = 'O';
                                else
                                  (lastValue = 'X');
                              });
                            }
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                          color: game.board![index].isEmpty
                              ? Colors.black38
                              : game.board![index] == 'X'
                                  ? Colors.amber
                                  : Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                              // color: game.board![index] == 'X'
                              //     ? Colors.amber
                              //     : Colors.blue,
                              fontSize: 64),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            result,
            style: TextStyle(color: Colors.black, fontSize: 54),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = 'X';
                GameOver = false;
                turn = 0;
                result = "";
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            label: const Text('StartAgain'),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
    );
  }

  Widget _HeaderText() {
    return Column(
      children: [
        Text(
          "Tic Tac Toe",
          style: TextStyle(
              color: Colors.teal, fontSize: 64, fontWeight: FontWeight.bold),
        ),
        Text(
          "${lastValue} turn",
          style: TextStyle(
              color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
