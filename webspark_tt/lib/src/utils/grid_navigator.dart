import 'dart:collection';
import 'package:webspark_tt/src/API/api_provider.dart';

class GridNavigator {
  late List<List<String>> grid;
  late int rows, cols;

  final List<Point> directions = [
    Point(x: -1, y: 0), Point(x: 1, y: 0), Point(x: 0, y: -1), Point(x: 0, y: 1),
    Point(x: -1, y: -1), Point(x: -1, y: 1), Point(x: 1, y: -1), Point(x: 1, y: 1)
  ];

  List<List<Point>> findShortestPaths(List<Task> tasks) {
    List<List<Point>> results = [];

    for (var task in tasks) {
      grid = task.field.map((row) => row.split('')).toList();
      rows = grid.length;
      cols = grid[0].length;
      results.add(_findPath(task.start, task.end));
    }

    return results;
  }

  List<Point> _findPath(Point start, Point end) {
    Queue<Point> queue = Queue();
    Map<Point, Point?> cameFrom = {};
    queue.add(start);
    cameFrom[start] = null;

    while (queue.isNotEmpty) {
      Point current = queue.removeFirst();

      if (current == end) {
        return _reconstructPath(cameFrom, end);
      }

      for (var direction in directions) {
        Point next = Point(x: current.x + direction.x, y: current.y + direction.y);
        if (_isValid(next) && !cameFrom.containsKey(next)) {
          queue.add(next);
          cameFrom[next] = current;
        }
      }
    }
    return [];
  }

  /// Восстанавливает путь от `end` до `start`
  List<Point> _reconstructPath(Map<Point, Point?> cameFrom, Point end) {
    List<Point> path = [];
    Point? current = end;
    while (current != null) {
      path.add(current);
      current = cameFrom[current];
    }
    return path.reversed.toList();
  }

  /// Проверяет, можно ли пройти в точку
  bool _isValid(Point p) {
    return p.x >= 0 &&
        p.y >= 0 &&
        p.x < rows &&
        p.y < cols &&
        grid[p.x][p.y] != 'X';
  }
}