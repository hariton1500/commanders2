// Returns a list of factories sorted by distance from the specified point
// @param point The reference point to calculate distances from
// @returns List<Base> Sorted list of factories by ascending distance
import 'package:commanders2/FLAME/factory.dart';
import 'package:commanders2/HELPERS/fp2.dart';
import 'package:commanders2/globals.dart';
import 'package:flame/game.dart';
Base? getNearestBaseTo({required Vector2 pos, required List<Base> from}) {
  double tmpDist = double.infinity;
  Base? nb;
  for (var base in from) {
    var dist = double.infinity;
    var p = findPath(maze, Point((pos.y / 10).toInt(), (pos.x / 10).toInt()), Point((base.position.y / 10).toInt(), (base.position.x / 10).toInt()));
    if (p.isNotEmpty) dist = p.length.toDouble();
    if (dist < tmpDist) {
      nb = base;
      tmpDist = dist;
    }
  }
  return nb;
}