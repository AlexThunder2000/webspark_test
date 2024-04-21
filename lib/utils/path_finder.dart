import 'dart:collection';

import 'package:webspark_test/model/grid.dart';
import 'package:webspark_test/model/point.dart';

class PathFinder {
  Grid grid;

  PathFinder(this.grid);

  List<Point> findPath(Point start, Point end) {
    Queue<List<Point>> queue = Queue<List<Point>>();
    queue.add([start]);
    Set<Point> visited = {start};

    while (queue.isNotEmpty) {
      List<Point> path = queue.removeFirst();
      Point current = path.last;
      if (current == end) {
        return path;
      }

      for (Point neighbor in grid.getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(List<Point>.from(path)..add(neighbor));
        }
      }
    }

    return [];
  }
}
