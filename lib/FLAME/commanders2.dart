import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';



class CommandersGame extends FlameGame with HasCollisionDetection, TapDetector {
  CommandersGame() : super(camera: CameraComponent.withFixedResolution(width: 500, height: 500));
  //final double gameWidth, gameHeight;
  double get width => size.x;
  double get height => size.y;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(Component(
      children: [
        PositionComponent(position: Vector2(0, 0), size: Vector2(50, 50)),
      ]
    ));
  }

}