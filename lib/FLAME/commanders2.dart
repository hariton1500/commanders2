import 'package:commanders2/FLAME/areas.dart';
import 'package:commanders2/FLAME/factory.dart';
import 'package:commanders2/FLAME/wall.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';



class CommandersGame extends FlameGame with HasCollisionDetection, TapDetector {
  CommandersGame() : super(camera: CameraComponent.withFixedResolution(width: 100, height: 100));
  //final double gameWidth, gameHeight;
  double get width => mapWidth.toDouble();
  double get height => mapHeight.toDouble();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(PlayArea());
    add(MenuArea());
    addMapElements();
  }
  
  void addMapElements() {
    for (int i = 0; i < mapList.length; i++) {
      List<String> line = mapList[i].split(',');
      for (int j = 0; j < line.length; j++) {
        if (line[j] == '1') {
          add(Wall(Vector2(j * 10 + 0, i * 10 + 0)));
        }
        if (line[j] == 'f') {
          add(Base(Vector2(j * 10 + 0, i * 10 + 0)));
        }
      }
    }
  }
}