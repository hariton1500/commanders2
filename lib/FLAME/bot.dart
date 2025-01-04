import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:commanders2/FLAME/rocket.dart';
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
  int damage = 0, life = 5;
  DateTime lastShotTime = DateTime.now();

  var text = TextComponent(
    text: '',
    textRenderer: TextPaint(style: const TextStyle(color: Colors.white, fontSize: 10)),
    anchor: Anchor.center,
  );


  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint.color = isPlayersBot ? Colors.blue : Colors.red;
    add(text..position = Vector2(5, 3));
  }

  @override
  String toString() {
    return 'Bot${position.toString()} | ${damage.toString()} | ${isAIInstalled.toString()} | ${isWeaponInstalled.toString()}';
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (damage >= life) {
      removeFromParent();
    }
    text.text = (life - damage).toString();
    //if bot has AI installed its mission to move to nearest non players base
    if (isAIInstalled) {
      if (path.isNotEmpty) {
        if (position.distanceTo(path[0]) < 1) {
          path.removeAt(0);
        }
      if (path.isNotEmpty) position += (path[0] - position).normalized() * 1;
      //print(position);
      }
      if (path.isEmpty) {
        //print('$this find path to...');
        var otherBases = game.children.whereType<Base>().where((b) => b.baseStatus != statusLikeBase).toList();
        //Base? nearestBaseToCapture = getNearestBaseTo(pos: position, from: otherBases);
        otherBases.shuffle();
        Base? nearestBaseToCapture = otherBases.firstOrNull;
        if (nearestBaseToCapture != null) {
          //print(nearestBaseToCapture.toString());
          var p = findPath(maze, Point((position.y / 10).toInt(), (position.x / 10).toInt()), Point((nearestBaseToCapture.position.y / 10).toInt(), (nearestBaseToCapture.position.x / 10).toInt()));
          if (p.isNotEmpty) {
            //print('path for bot is found');
            path = p.map((e) => Vector2(e.y * 10, e.x * 10)).toList();
          }
        }
      }
      //check if bot is on any base
      game.children.whereType<Base>().forEach((element) {
        //print('Checking if bot is at base ${element.position}');
        if (element.position.distanceTo(position) < 1) {
          //print('bot is at base');
          element.setColor(paint.color);
          element.baseStatus = statusLikeBase;
          //path.clear();
          //enterBase(element);
        }
      });
    }

    if (isWeaponInstalled && activeRocket == null) {
      //print('shoot checking...');
      List<Bot> targetBots = [];
      try {
        targetBots = game.children.whereType<Bot>().where((b) => b.isPlayersBot != isPlayersBot).where((b) => b.position.distanceTo(position) <= 100).toList();
      } catch (e) {
        //print(e);
      }
      if (targetBots.isNotEmpty && (DateTime.now().difference(lastShotTime).inMilliseconds > 1000)) {
        //print('shooting...');
        activeRocket = Rocket(position, velocity: Vector2.zero(), shooter: this, target: targetBots.first);
        game.add(activeRocket!);
        lastShotTime = DateTime.now();
      }
    }
  }
}