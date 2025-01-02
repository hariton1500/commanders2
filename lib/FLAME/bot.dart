import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:commanders2/FLAME/rocket.dart';
import 'package:commanders2/HELPERS/fb.dart';
import 'package:commanders2/HELPERS/fp2.dart';
import 'package:commanders2/globals.dart';
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
    anchor: Anchor.topLeft,
    paint: Paint()..color = Colors.grey);

  Vector2 velocity;
  bool isPlayersBot;
  int get statusLikeBase => isPlayersBot ? 1 : 2;
  bool isAIInstalled;
  bool isWeaponInstalled;
  Base? targetBase;
  List<Vector2> path = [];
  Rocket? activeRocket;
  int damage = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint.color = isPlayersBot ? Colors.green : Colors.red;
  }

  @override
  String toString() {
    return 'Bot(${position.toString()})';
  }

  @override
  void update(double dt) {
    super.update(dt);

    //if bot has AI installed its mission to move to nearest non players base
    if (isAIInstalled) {
      if (path.isNotEmpty) {
        if (position.distanceTo(path[0]) < 1) {
          path.removeAt(0);
        }
      if (path.isNotEmpty) position += (path[0] - position).normalized() * 1;
      }
      if (path.isEmpty) {
        print('$this find path to...');
        var otherBases = game.children.whereType<Base>().where((b) => b.baseStatus != statusLikeBase).toList();
        Base? nearestBaseToCapture = getNearestBaseTo(pos: position, from: otherBases);
        if (nearestBaseToCapture != null) {
          print(nearestBaseToCapture.toString());
          var p = findPath(maze, Point((position.y / 10).toInt(), (position.x / 10).toInt()), Point((nearestBaseToCapture.position.y / 10).toInt(), (nearestBaseToCapture.position.x / 10).toInt()));
          if (p.isNotEmpty) {
            print('path for bot is found');
            path = p.map((e) => Vector2(e.y * 10, e.x * 10)).toList();
          }
        }
      }
      //check if bot is on any base
      game.children.whereType<Base>().forEach((element) {
        //print('Checking if bot is at base ${element.position}');
        if (element.position.distanceTo(position) < 1) {
          print('bot is at base');
          element.setColor(isPlayersBot ? Colors.green : Colors.red);
          element.baseStatus = statusLikeBase;
          //path.clear();
          //enterBase(element);
        }
      });
    }

    if (isWeaponInstalled && activeRocket == null) {
      Bot? targetBot;
      try {
        targetBot = game.children.whereType<Bot>().where((b) => b.isPlayersBot != isPlayersBot).firstWhere((b) => b.position.distanceTo(position) <= 100);
      } catch (e) {
        print(e);
      }
      if (targetBot != null) {
        activeRocket = Rocket(position, velocity: velocity, shooter: this, target: targetBot);
        game.world.add(activeRocket!);
      }
    }
  }
}