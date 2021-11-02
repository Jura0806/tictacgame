import 'package:flutter/material.dart';
import 'package:tictacgame/services/logic_games.dart';
import 'package:tictacgame/utils/colors.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  String lastValue = "X";
  bool gameOver  = false;
  List<int> scoreboard = [0,0,0,0,0,0,0,0,0];
  int turn = 0;
  String result = "";

  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("O'yin navbati ${lastValue} o'yinchida",
          style: TextStyle(
            color: Colors.white,
            fontSize: size / 15,
          ),),
          SizedBox(height: 20,),
          Container(
            width: size,
            height: size,
            child: GridView.count(crossAxisCount: Game.boardCount ~/3,
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardCount, (index) {
              return InkWell(
                onTap: gameOver ? null : (){

                  setState(() {
                    game.board![index] = lastValue;
                    turn++;
                    gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);
                    if(gameOver){
                      result = "$lastValue o'yinchi yutdi!";
                    }else if(!gameOver && turn == 9){
                      result = "Durrang natija!";
                      gameOver = true;
                    }
                     if(lastValue == "X") lastValue = "O";
                     else lastValue = "X";
                  });
                },
                child: Container(
                  width: Game.blocSize,
                  height: Game.blocSize,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Center(
                    child: Text(game.board![index],
                      style: TextStyle(
                        color: game.board![index] == "X"
                            ? Colors.brown
                            : Colors.red,
                        fontSize: 60.0
                      ),
                    ),
                  ),
                ),
              );
            }),
            ),
          ),
         SizedBox(height: 25,),
         Text(result, style: TextStyle(fontSize: 45),),
         ElevatedButton.icon(
           onPressed: (){
             setState(() {
               game.board = Game.initGameBoard();
               lastValue = "X";
               gameOver = false;
               turn = 0;
               result = "";
               scoreboard = [0,0,0,0,0,0,0,0];
             });
           },
           icon: Icon(Icons.refresh),
           label: Text("O'yinni qaytadan boshlash!"),
         ),
        ],
      ),
    );
  }
}
