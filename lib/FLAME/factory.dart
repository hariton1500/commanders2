import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/HELPERS/findpath.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Base extends RectangleComponent with TapCallbacks, HasGameReference<CommandersGame> {
  Base(Vector2 position) : super(anchor: Anchor.topLeft, size: Vector2.all(10), position: position, paint: Paint()..color = Colors.grey);

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    //pressedBase = this;
    //game.add(BasePage(game: game, base: this));
    print('Base onTapDown: ${position}');
    //find path from player to tapPosition
    //use findPath function from findpath.dart
    //change this base to 0 in maze
    maze[(position.y / 10).toInt()][(position.x / 10).toInt()] = 0;
    List<Point> path = findPath(maze, Point((playerPosition.y / 10).toInt(), (playerPosition.x / 10).toInt()), Point((position.y / 10).toInt(), (position.x / 10).toInt()));
    //print(path);
    if (path.isNotEmpty) {
      print('path found');
      newPath = path.map((e) => Vector2(e.y * 10, e.x * 10)).toList();
    }
  }
}