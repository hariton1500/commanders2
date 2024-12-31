import 'package:commanders2/FLAME/bot.dart';
import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Rocket extends CircleComponent with HasCollisionDetection, HasGameReference<CommandersGame> {
  Rocket(Vector2 position, Vector2 velocity, {required this.shooter, required this.target}) : super(position: position, radius: 3, paint: Paint()..color = Colors.red);

  Bot target, shooter;

  @override
  void update(double dt) {
    super.update(dt);
    position += position.projection(target.position).normalized() * dt;
    if (target.position.distanceTo(position) < 1) {
    }
  }
}