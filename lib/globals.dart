import 'package:commanders2/FLAME/factory.dart';
import 'package:flame/components.dart';

Vector2 wallSize = Vector2.all(10);
Vector2 baseSize = Vector2.all(20);
List<String> mapList = [];
int get mapHeight => mapList.length;
int get mapWidth => mapList.isNotEmpty ? mapList[0].split(',').length * (wallSize.x.round()) : 0;

Vector2 tapPosition = Vector2.zero();
List<Vector2> newPath = [];
Vector2 playerPosition = Vector2.all(20);

List<List<int>> get maze => mapList.map((String e) {
  return e.split(',').map((String e) {
      return e == '' ? 0 : 1;
    }).toList();
}).toList();

double freePlayersConstructionBlocks = 0;
Base? selectedBase;
bool isWin = false;
double botSpeed = 1;