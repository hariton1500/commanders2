import 'package:commanders2/FLAME/areas.dart';
import 'package:commanders2/FLAME/bot.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:commanders2/FLAME/wall.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';



class CommandersGame extends FlameGame with HasCollisionDetection, TapDetector, HasGameRef<CommandersGame> {
  CommandersGame() : super(camera: CameraComponent.withFixedResolution(width: 500, height: 500));


  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final gameSize = gameRef.size;
    print(gameSize);
    final startPlayerBot = Bot(position: Vector2(20, 20), velocity: Vector2(0, 0), radius: 10, isPlayersBot: true, isAIInstalled: true, isWeaponInstalled: true);
    final startEnemyBot = Bot(position: Vector2(gameSize.x - 20, gameSize.y - 20), velocity: Vector2(0, 0), radius: 10, isPlayersBot: false, isAIInstalled: true, isWeaponInstalled: true);
    add(PlayArea());
    add(MenuArea());
    addMapElements();

    add(startPlayerBot);
    add(startEnemyBot);
  }
  
  void addMapElements() {
    for (int i = 0; i < mapList.length; i++) {
      List<String> line = mapList[i].split('');
      for (int j = 0; j < line.length; j++) {
        if (line[j] == '1') {
          add(Wall(Vector2(j * 10 + 0, i * 10 + 0)));
        }
        if (line[j] == 'i') {
          var base = Base(Vector2(j * 10 + 0, i * 10 + 0));
          add(base);
          //for all f around base set base to base
          for (int k = -1; k < 2; k++) {
            for (int l = -1; l < 2; l++) {
              if (mapList[i + k][j + l] == 'f') {
                add(BaseWall(Vector2((j + l) * 10 + 0, (i + k) * 10 + 0), base: base));
              }
            }
          }
        }
      }
    }
  }
}