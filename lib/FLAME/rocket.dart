import 'package:commanders2/FLAME/bot.dart';
import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/wall.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Rocket extends CircleComponent with CollisionCallbacks, HasGameReference<CommandersGame> {
  Rocket(Vector2 position, {required this.velocity, required this.shooter, required this.target}) : super(position: position, radius: 3, paint: Paint()..color = Colors.grey);

  Bot target, shooter;
  Vector2 velocity;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint.color = shooter.paint.color;
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity = (target.position - position).normalized() * rocketSpeed;
    position += velocity * dt;
    if (position.distanceTo(target.position) <= radius) {
      try {
        shooter.activeRocket = null;
        target.damage++;
      } catch (e) {}
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Wall) {
      shooter.activeRocket = null;
      removeFromParent();
    }
  }
}