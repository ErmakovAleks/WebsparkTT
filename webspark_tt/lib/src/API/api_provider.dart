import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskList {
  bool error;
  String message;
  List<Task> data;

  TaskList({
    required this.error,
    required this.message,
    required this.data,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        error: json['error'],
        message: json['message'],
        data:
            List<Task>.from(json['data'].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Task {
  String id;
  List<String> field;
  Point start;
  Point end;

  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        field: List<String>.from(json['field'].map((x) => x)),
        start: Point.fromJson(json['start']),
        end: Point.fromJson(json['end']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'field': List<dynamic>.from(field.map((x) => x)),
        'start': start.toJson(),
        'end': end.toJson(),
      };
}

class Point {
  int x;
  int y;

  Point({
    required this.x,
    required this.y,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        x: json['x'],
        y: json['y'],
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };

  @override
  String toString() => '{x:$x, y:$y}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point && runtimeType == other.runtimeType && x == other.x && y == other.y;

   @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class ApiProvider {
  Future<TaskList> fetchTasks(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return TaskList(error: true, message: 'Invalid URL', data: []);
    }

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return TaskList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
