import 'package:commanders2/FLAME/commanders2.dart';
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
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    print('PlayArea onTapDown: ${event.localPosition}');
    tapPosition = event.localPosition;
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
