import 'dart:collection';
import 'package:rxdart/subjects.dart';
import 'package:webspark_tt/src/models/models.dart';

class GridNavigator {
  final List<Task> tasks;
  final progress = BehaviorSubject<double>.seeded(0.0);

  final List<Point> directions = [
    Point(x: -1, y: 0),
    Point(x: 1, y: 0),
    Point(x: 0, y: -1),
    Point(x: 0, y: 1),
    Point(x: -1, y: -1),
    Point(x: -1, y: 1),
    Point(x: 1, y: -1),
    Point(x: 1, y: 1)
  ];

  GridNavigator({required this.tasks});

  Future<List<List<Point>>> findShortestPaths() async {
    List<List<Point>> results = [];
    int totalTasks = tasks.length;
    int processedTasks = 0;

    for (var task in tasks) {
      List<List<String>> grid = task.field.map((row) => row.split('')).toList();
      List<Point> path =
          _findPath(grid, task.start, task.end, processedTasks / totalTasks);
      results.add(path);

      processedTasks++;
      progress.add(processedTasks / totalTasks);
    }

    return results;
  }

  String formatPath(List<Point> path) {
    return path.map((p) => p.toString()).join('->');
  }

  List<Point> _findPath(
    List<List<String>> grid,
    Point start,
    Point end,
    double baseProgress,
  ) {
    Queue<Point> queue = Queue();
    Map<Point, Point?> cameFrom = {};
    queue.add(start);
    cameFrom[start] = null;

    int rows = grid.length;
    int cols = grid[0].length;
    int iterations = 0;
    int maxIterations = rows * cols;
    double lastUpdate = baseProgress;

    while (queue.isNotEmpty) {
      Point current = queue.removeFirst();
      iterations++;

      if (current == end) {
        return _reconstructPath(cameFrom, end);
      }

      for (var direction in directions) {
        Point next =
            Point(x: current.x + direction.x, y: current.y + direction.y);
        if (_isValid(next, rows, cols, grid) && !cameFrom.containsKey(next)) {
          queue.add(next);
          cameFrom[next] = current;
        }
      }

      double currentProgress =
          baseProgress + (iterations / maxIterations) * (1 / tasks.length);
      if (currentProgress - lastUpdate > 0.05) {
        progress.add(currentProgress);
        lastUpdate = currentProgress;
      }
    }

    return [];
  }

  List<Point> _reconstructPath(Map<Point, Point?> cameFrom, Point end) {
    List<Point> path = [];
    Point? current = end;
    while (current != null) {
      path.add(current);
      current = cameFrom[current];
    }
    return path.reversed.toList();
  }

  bool _isValid(Point p, int rows, int cols, List<List<String>> grid) {
    return p.x >= 0 &&
        p.y >= 0 &&
        p.x < rows &&
        p.y < cols &&
        grid[p.x][p.y] != 'X';
  }
}
