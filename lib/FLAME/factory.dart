import 'package:commanders2/FLAME/commanders2.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Base extends RectangleComponent with TapCallbacks, HasGameReference<CommandersGame> {
  Base(Vector2 position) : super(anchor: Anchor.topLeft, size: Vector2.all(10), position: position, paint: Paint()..color = Colors.grey);
}