import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends RectangleComponent with HasGameReference<CommandersGame> {
  Player() : super(anchor: Anchor.topLeft, size: Vector2.all(10), position: Vector2(20, 20), paint: Paint()..color = Colors.red);

  List<Vector2> path = [];

  @override
  void update(double dt) {
    super.update(dt);
    if (newPath.isNotEmpty) {
      path = newPath;
      newPath = [];
    }
    if (path.isNotEmpty) {
      if (position.distanceTo(path[0]) < 1) {
        path.removeAt(0);
      }
      if (path.isNotEmpty) {
        position += (path[0] - position).normalized() * 1;
      } else {
        //check if player is on any base
        game.children.whereType<Base>().forEach((element) {
          print('Checking if player is on base ${element.position}');
          if (element.position.distanceTo(position) < 14) {
            print('Player on base');
            element.setColor(Colors.green);
            enterBase(element);
          }
        });
      }
    }
    playerPosition = position;
  }
  
  void enterBase(Base element) {}
}

class PathElement extends RectangleComponent with HasGameReference<CommandersGame> {
  PathElement(Vector2 position) : super(anchor: Anchor.topLeft, size: Vector2.all(2), position: position, paint: Paint()..color = Colors.blue);
}