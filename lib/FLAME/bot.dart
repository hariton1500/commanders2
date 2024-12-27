import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';



class Bot extends CircleComponent with CollisionCallbacks, HasGameRef<CommandersGame> {
  Bot({
    required this.velocity,
    required super.position,
    required double radius,
    required this.isPlayersBot,
  }) : super(
    radius: radius,
    anchor: Anchor.center,
    paint: Paint()..color = Colors.grey);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint.color = isPlayersBot ? Colors.green : Colors.red;
  }

  Vector2 velocity;
  bool isPlayersBot;
  bool isCaptureBases = false;
  bool isShootEnemies = false;
  bool isWeaponInstalled = false;
  Base? targetBase;
  //Rocket? rocket;
  

  @override
  void update(double dt) {
    super.update(dt);
    //print('bot position: ${position.toString()}');
    /*
    //movements updates
    if (isPlayersBot) {
      if (isCaptureBases) {
        //move to capture neutral and enemy bases
        //find closest neutral or enemy base
        try {
          targetBase = game.world.children.query<Base>().where((element) => element.status == BaseStatus.neutral || element.status == BaseStatus.enemies).reduce((value, element) => (value.position - position).length < (element.position - position).length ? value : element);  
        } catch (e) {
          velocity = Vector2.zero();
        }
        
        //print('targetBase: ${targetBase?.position.toString()}');
        if (targetBase != null) {
          velocity = (targetBase!.position - position).normalized() * botSpeed;
        } else {
          velocity = Vector2.zero();
        }
      }
    } else {
      if (isCaptureBases) {
        //move to mine or neutral base
        //find closest mine or neutral base
        try {
          targetBase = game.world.children.query<Base>().where((element) => element.status == BaseStatus.neutral || element.status == BaseStatus.mine).reduce((value, element) => (value.position - position).length < (element.position - position).length ? value : element);
        } catch (e) {
          velocity = Vector2.zero();
        }
        if (targetBase != null) {
          velocity = (targetBase!.position - position).normalized() * botSpeed;
        } else {
          velocity = Vector2.zero();
        }
      }
    }
    position += velocity * dt;    

    //rich of targetBase check
    if (targetBase != null && position.distanceTo(targetBase!.position) <= 2) {
      print('got target base');
      targetBase?.status = status == BotStatus.mine ? BaseStatus.mine : BaseStatus.enemies;
      if (status == BotStatus.enemies) {
        targetBase?.isProduceBotsPermanent = true;
      }
    }

    //if enemy bot in range = weaponRange and installed weapon and isShootEnemies is true and rocket is null, create rocket
    if (isWeaponInstalled && isShootEnemies && rocket == null) {
      //find closest enemy bot
      try {
        Bot? closestEnemyBot = game.world.children.query<Bot>().where((element) => element.status != status && element.status != BotStatus.neutral).reduce((value, element) => (value.position - position).length < (element.position - position).length ? value : element);
        //check if closest enemy bot is in range
        if (position.distanceTo(closestEnemyBot.position) <= weaponRange) {
          //create rocket
          rocket = Rocket(
            targetBot: closestEnemyBot,
            shooterBot: this,
            velocity: Vector2.zero(),
            position: position,
            radius: rocketRadius,
          );
          game.world.add(rocket!);
        }
      } catch (e) {
        
      }
      
    }
    
    */
  }

}