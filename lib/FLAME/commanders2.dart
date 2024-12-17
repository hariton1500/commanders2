import 'package:commanders2/FLAME/areas.dart';
import 'package:commanders2/FLAME/wall.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';



class CommandersGame extends FlameGame with HasCollisionDetection, TapDetector {
  CommandersGame() : super(camera: CameraComponent.withFixedResolution(width: 50, height: 50));
  //final double gameWidth, gameHeight;
  double get width => size.x;
  double get height => size.y;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(PlayArea());
    add(MenuArea());
    addMapElements();
  }
  
  void addMapElements() {
    for (int i = 0; i < mapList.length; i++) {
      for (int j = 0; j < mapList[i].length; j++) {
        if (mapList[i][j] == '1') {
          add(Wall(Vector2(j * 10 / 2 + 5, i * 10 + 5)));
        }
      }
    }
  }
}