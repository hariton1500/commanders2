import 'package:flame/components.dart';

Vector2 wallSize = Vector2.all(10);
Vector2 baseSize = Vector2.all(20);
List<String> mapList = [];
int get mapHeight => mapList.length;
int get mapWidth => mapList.isNotEmpty ? mapList[0].split(',').length * (wallSize.x.round()) : 0;