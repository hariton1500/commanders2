import 'package:commanders2/FLAME/commanders2.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Wall extends RectangleComponent with HasGameReference<CommandersGame> {
  Wall(Vector2 position) : super(position: position, anchor: Anchor.center, size: Vector2(10, 10), paint: Paint()..color = Colors.green);
}