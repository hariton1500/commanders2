import 'package:commanders2/FLAME/bot.dart';
import 'package:commanders2/FLAME/commanders2.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.game, required this.base});
  final CommandersGame game;
  final Base base;

  @override
  State<BasePage> createState() => _BasePageState();
}

int botConstructionCosts = 1;
late bool isWeaponInstalled;
late bool isCaptureBases;
late bool isShootEnemies;
late bool isProduceBotsPermanent;

class _BasePageState extends State<BasePage> {

  @override
  void initState() {
    super.initState();
    isWeaponInstalled = widget.base.isWeaponInstalled;
    isCaptureBases = widget.base.isAIInstalled;
    isShootEnemies = false;
    isProduceBotsPermanent = widget.base.isProducingBotPermanently;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      //color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Free blocks: $freePlayersConstructionBlocks'),
          Text('Current bot construction costs: $botConstructionCosts blocks.'),
          SwitchListTile(value: isWeaponInstalled, onChanged: (value) {
            setState(() {
              isWeaponInstalled = value;
              if (isWeaponInstalled) {
                botConstructionCosts += 1;
              } else {
                botConstructionCosts -= 1;
              }
            });
          },
          title: const Text('Install weapon'),
          subtitle: const Text('This will increase bot construction costs by 1 block and this bot will be able to shoot enemies.'),
          ),
          const Text('Bots mission options:'),
          SwitchListTile(value: isCaptureBases, onChanged: (value) {
            setState(() {
              isCaptureBases = value;
            });
          },
          title: const Text('Capture bases'),
          subtitle: const Text('This bot will try to capture bases.'),
          ),
          SwitchListTile(value: isShootEnemies, onChanged: (value) {
            setState(() {
              isShootEnemies = value;
            });
          },
          title: const Text('Shoot enemies'),
          subtitle: const Text('This bot will try to shoot enemies.'),
          ),
          SwitchListTile(value: isProduceBotsPermanent, onChanged: (value) {
            setState(() {
              isProduceBotsPermanent = value;
            });
          },
          title: const Text('Produce bots permanently'),
          subtitle: const Text('This base will produce bots permanently.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: freePlayersConstructionBlocks < botConstructionCosts ? null : () async {
                  if (freePlayersConstructionBlocks >= botConstructionCosts) {
                    widget.game.overlays.remove('BasePage');
                    freePlayersConstructionBlocks -= botConstructionCosts;
                    //add bot to game at this base position
                    widget.game.world.add(Bot(
                      velocity: Vector2.zero(),
                      position: widget.base.position,
                      radius: 5,
                      isPlayersBot: true,
                    )..isCaptureBases = isCaptureBases
                    ..isShootEnemies = isShootEnemies
                    ..isWeaponInstalled = isWeaponInstalled);
                    await widget.game.lifecycleEventsProcessed;
                    selectedBase!
                      ..isProducingBotPermanently = isProduceBotsPermanent
                      ..isAIInstalled = isCaptureBases
                      ..isWeaponInstalled = isWeaponInstalled;
                  }
                },
                child: const Text('Build this bot')
              ),
              //cancell button
              ElevatedButton(
                onPressed: () {
                  widget.game.overlays.remove('BasePage');
                },
                child: const Text('Cancel')
              )
            ],
          )
        ],
      ),
    );
  }
}