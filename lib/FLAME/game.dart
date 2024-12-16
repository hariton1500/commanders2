import 'package:commanders2/FLAME/commanders2.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late final CommandersGame game;

  @override
  void initState() {
    super.initState();
    //gameWidth = 500;
    //gameHeight = 500;//MediaQuery.of(context).size.height;
    game = CommandersGame();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Center(
                child: FittedBox(
                  child: SizedBox(
                    width: 500,
                    height: 500,
                    child: GameWidget(
                      game: game,
                      /*
                      overlayBuilderMap: {
                        'BasePage': (_, game_) => BasePage(game: game, base: pressedBase),
                        'WinPage': (_, game_) => WinPage(game: game, isWin: isWin,),
                      },*/
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
