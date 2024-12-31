import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';



class Bot extends RectangleComponent with CollisionCallbacks, HasGameRef<CommandersGame> {
  Bot({
    required this.velocity,
    required super.position,
    required double radius,
    required this.isPlayersBot,
    required this.isAIInstalled,
    required this.isWeaponInstalled,
  }) : super(
    size: Vector2.all(radius),
    anchor: Anchor.center,
    paint: Paint()..color = Colors.grey);

  Vector2 velocity;
  bool isPlayersBot;
  bool isAIInstalled;
  bool isWeaponInstalled;
  Base? targetBase;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint.color = isPlayersBot ? Colors.green : Colors.red;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    if (position.x < 0 || position.x > game.size.x || position.y < 0 || position.y > game.size.y) {
      removeFromParent();
    }
  }
    


}