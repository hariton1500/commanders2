//import 'dart:collection';

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class Node {
  final Point point;
  final int cost;
  final int heuristic;

  Node(this.point, this.cost, this.heuristic);

  int get totalCost => cost + heuristic;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Node && runtimeType == other.runtimeType && point == other.point;

  @override
  int get hashCode => point.hashCode;
}

int heuristic(Point a, Point b) {
  return (a.x - b.x).abs() + (a.y - b.y).abs();
}

List<Point> findPath(List<List<int>> maze, Point start, Point end) {
  final openSet = <Node>[];
  final cameFrom = <Point, Point>{};
  final gScore = <Point, int>{};
  final fScore = <Point, int>{};

  gScore[start] = 0;
  fScore[start] = heuristic(start, end);
  openSet.add(Node(start, 0, fScore[start]!));

  while (openSet.isNotEmpty) {
    openSet.sort((a, b) => a.totalCost.compareTo(b.totalCost));
    final current = openSet.removeAt(0).point;

    if (current == end) {
      final path = <Point>[];
      var temp = current;
      while (cameFrom.containsKey(temp)) {
        path.add(temp);
        temp = cameFrom[temp]!;
      }
      path.add(start);
      return path.reversed.toList();
    }

    for (final direction in <Point>[Point(0, 1), Point(1, 0), Point(0, -1), Point(-1, 0)]) {
      final neighbor = Point(current.x + direction.x, current.y + direction.y);
      if (neighbor.x >= 0 &&
          neighbor.x < maze.length &&
          neighbor.y >= 0 &&
          neighbor.y < maze[0].length &&
          maze[neighbor.x][neighbor.y] == 0) {
        final tentativeGScore = gScore[current]! + 1;

        if (tentativeGScore < (gScore[neighbor] ?? double.infinity.toInt())) {
          cameFrom[neighbor] = current;
          gScore[neighbor] = tentativeGScore;
          fScore[neighbor] = tentativeGScore + heuristic(neighbor, end);
          if (!openSet.any((node) => node.point == neighbor)) {
            openSet.add(Node(neighbor, gScore[neighbor]!, fScore[neighbor]!));
          }
        }
      }
    }
  }
  return [];
}
