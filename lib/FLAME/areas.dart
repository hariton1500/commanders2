import 'package:commanders2/FLAME/bot.dart';
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
    List<Point> path = findPath(maze, Point((playerPosition.y / 10).toInt(), (playerPosition.x / 10).toInt()), Point((tapPosition.y / 10).toInt(), (tapPosition.x / 10).toInt()));
    //print(path);
    if (path.isNotEmpty) {
      print('path found');
      newPath = path.map((e) => Vector2(e.y * 10, e.x * 10)).toList();
    }
    game.addAll(path.map((e) => PathElement(Vector2(e.y * 10, e.x * 10))));
    //wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    game.removeAll(game.children.whereType<PathElement>());
  }
}

class MenuArea extends RectangleComponent with HasGameReference<CommandersGame> {
  MenuArea() : super(anchor: Anchor.topLeft);

  var textC1 = TextComponent(
    text: 'Menu',
    textRenderer: TextPaint(style: const TextStyle(color: Colors.white, fontSize: 14)),
    anchor: Anchor.topLeft,
  );
  var botsData = TextComponent(
    text: '',
    textRenderer: TextPaint(style: const TextStyle(color: Colors.white, fontSize: 14)),
    anchor: Anchor.topLeft,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.size.x, 50);
    position = Vector2(0, game.size.y);
    paint.color = Colors.black;
    //add(textC1..position = Vector2(0, 0));
    add(botsData..position = Vector2(10, 0));
  }

  @override
  void update(double dt) {
    super.update(dt);
    //textC1.text = game.children.query<Bot>().length.toString();
    //print(game.children.length);
    botsData.text = game.children.query<Bot>().map((e) => e.toString()).join('\n');
  }
}
