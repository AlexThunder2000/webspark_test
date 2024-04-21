import 'package:webspark_test/model/point.dart';

class Grid {
  List<List<String>> field;

  Grid(this.field);

  bool isBlocked(Point point) {
    return field[point.y][point.x] == 'X';
  }

  bool inBounds(Point point) {
    return point.x >= 0 && point.y >= 0 && point.x < field[0].length && point.y < field.length;
  }

  List<Point> getNeighbors(Point point) {
    List<Point> directions = [
      Point(1, 0),
      Point(-1, 0),
      Point(0, 1),
      Point(0, -1),
      Point(1, 1),
      Point(-1, -1),
      Point(1, -1),
      Point(-1, 1)
    ];

    List<Point> neighbors = [];
    for (Point dir in directions) {
      Point newPoint = Point(point.x + dir.x, point.y + dir.y);
      if (inBounds(newPoint) && !isBlocked(newPoint)) {
        neighbors.add(newPoint);
      }
    }
    return neighbors;
  }
}
