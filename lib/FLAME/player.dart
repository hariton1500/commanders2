import 'package:commanders2/FLAME/commanders2.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Player extends RectangleComponent with TapCallbacks, HasGameReference<CommandersGame> {
  Player() : super(anchor: Anchor.topLeft, size: Vector2.all(10), position: Vector2(20, 20), paint: Paint()..color = Colors.red);
}