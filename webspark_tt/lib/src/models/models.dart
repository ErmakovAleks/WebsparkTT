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
        data: List<Task>.from(json['data'].map((x) => Task.fromJson(x))),
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
        'x': x.toString(),
        'y': y.toString(),
      };

  @override
  String toString() => '($x, $y)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class Result {
  final List<Point> steps;
  final String path;

  Result({required this.steps, required this.path});

  Map<String, dynamic> toJson() => {
        "steps": steps.map((step) => step.toJson()).toList(),
        "path": path,
      };
}

class ResultRequest {
  final String id;
  final Result result;

  ResultRequest({required this.id, required this.result});

  Map<String, dynamic> toJson() => {
        "id": id,
        "result": result.toJson(),
      };
}

class ResultsResponse {
  final bool error;
  final String message;
  final List<ResponseData> data;

  ResultsResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ResultsResponse.fromJson(Map<String, dynamic> json) {
    return ResultsResponse(
      error: json["error"],
      message: json["message"],
      data: List<ResponseData>.from(
        json["data"].map((x) => ResponseData.fromJson(x)),
      ),
    );
  }
}

class ResponseData {
  final String id;
  final bool correct;

  ResponseData({
    required this.id,
    required this.correct,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        id: json["id"],
        correct: json["correct"],
      );
}

class CompletedTask {
  final Task task;
  final List<Point> points;
  final String path;

  CompletedTask({
    required this.task,
    required this.points,
    required this.path,
  });
}
