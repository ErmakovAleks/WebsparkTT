import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webspark_tt/src/models/models.dart';

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

  Future<ResultsResponse> sendResults(List<ResultRequest> results) async {
    final url = Uri.parse('https://flutter.webspark.dev/flutter/api');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(results.map((r) => r.toJson()).toList());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return ResultsResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
