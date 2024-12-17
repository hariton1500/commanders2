import 'package:commanders2/FLAME/commanders2.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayArea extends RectangleComponent with HasGameReference<CommandersGame> {
  PlayArea() : super(children: [RectangleHitbox()]);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height - 50);
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
