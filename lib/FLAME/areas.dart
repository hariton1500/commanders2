import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/player.dart';
import 'package:commanders2/HELPERS/fp2.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class PlayArea extends RectangleComponent with TapCallbacks, HasGameReference<CommandersGame> {
  PlayArea() : super(children: [RectangleHitbox()]);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(500, 500);
  }

  @override
  Future<void> onTapDown(TapDownEvent event) async {
    super.onTapDown(event);
    print('PlayArea onTapDown: ${event.localPosition}');
    tapPosition = event.localPosition;
    //find path from player to tapPosition
    //use findPath function from findpath.dart
    if (game.world.children.query<Player>().isNotEmpty) {

      print(findPath(maze, Point(game.world.children.query<Player>().first.position.y.toInt(), game.world.children.query<Player>().first.position.x.toInt()), Point(tapPosition.x.toInt(), tapPosition.y.toInt())));
    } else {
      print('No player found');
      List<Point> path = findPath(maze, Point(2, 2), Point((tapPosition.y / 10).toInt(), (tapPosition.x / 10).toInt()));
      print(path);
      game.addAll(path.map((e) => PathElement(Vector2(e.y * 10, e.x * 10))));
      //wait for 2 seconds
      await Future.delayed(const Duration(seconds: 2));
      game.removeAll(game.children.whereType<PathElement>());
    }
  }
}

class MenuArea extends RectangleComponent with HasGameReference<CommandersGame> {
  MenuArea() : super(children: []);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, 50);
    position = Vector2(0, game.height - 50);
    paint.color = Colors.grey;
  }
}
