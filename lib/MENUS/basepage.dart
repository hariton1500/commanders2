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
late bool isAIInstalled;
late bool isProduceBotsPermanent;

class _BasePageState extends State<BasePage> {

  @override
  void initState() {
    super.initState();
    isWeaponInstalled = widget.base.isWeaponInstalled;
    isAIInstalled = widget.base.isAIInstalled;
    isProduceBotsPermanent = widget.base.isProducingBotPermanently;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      //color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Free blocks: ${freePlayersConstructionBlocks.toInt()}'),
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
          SwitchListTile(value: isAIInstalled, onChanged: (value) {
            setState(() {
              isAIInstalled = value;
              if (isAIInstalled) {
                botConstructionCosts += 1;
              } else {
                botConstructionCosts -= 1;
              }
            });
          },
          title: const Text('Install AI'),
          subtitle: const Text('This will increase bot construction costs by 1 block and this bot will be able to capture bases.'),
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
                    )..isCaptureBases = isAIInstalled
                    ..isShootEnemies = isWeaponInstalled);
                    await widget.game.lifecycleEventsProcessed;
                    selectedBase!
                      ..isProducingBotPermanently = isProduceBotsPermanent
                      ..isAIInstalled = isAIInstalled
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