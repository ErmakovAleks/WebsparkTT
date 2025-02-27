import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webspark_tt/src/API/api_provider.dart';
import 'package:webspark_tt/src/models/models.dart';
import 'package:webspark_tt/src/routes/router.dart';
import 'package:webspark_tt/src/utils/error_handable.dart';
import 'package:webspark_tt/src/utils/grid_navigator.dart';

class ProcessScreenViewModel with ErrorHandable {
  final ApiProvider _provider;
  final GridNavigator _gridNavigator;
  Stream<double> get progress => _gridNavigator.progress.stream;
  final isLoading = BehaviorSubject<bool>.seeded(false);
  List<List<Point>> _results = [];

  ProcessScreenViewModel({
    required ApiProvider provider,
    required GridNavigator gridNavigator,
  })  : _provider = provider,
        _gridNavigator = gridNavigator;

  Future<void> findShortestPaths() async {
    isLoading.add(true);
    _results = await _gridNavigator.findShortestPaths();
    isLoading.add(false);
  }

  void buttonTapped(BuildContext context) {
    isLoading.add(true);
    _provider.sendResults(_request()).then((value) {
      if (context.mounted) Navigator.of(context).pushNamed(AppRouteKeys.resultList, arguments: _completedTasks());
      isLoading.add(false);
    }).catchError((error) {
      debugPrint('<!> Request error: $error');
      if (context.mounted) showAlertDialog(context, 'Error', 'Error from server: $error');
      isLoading.add(false);
    });
  }

  List<ResultRequest> _request() {
    List<ResultRequest> results = [];

    for (var i = 0; i < _gridNavigator.tasks.length; i++) {
      final result = ResultRequest(
        id: _gridNavigator.tasks[i].id,
        result: Result(
          steps: _results[i],
          path: _gridNavigator.formatPath(_results[i]),
        ),
      );
      results.add(result);
    }

    return results;
  }

  List<CompletedTask> _completedTasks() {
    List<CompletedTask> results = [];
    for (var i = 0; i < _results.length; i++) {
      final completedTask = CompletedTask(
        task: _gridNavigator.tasks[i],
        points: _results[i],
        path: _gridNavigator.formatPath(
          _results[i],
        ),
      );

      results.add(completedTask);
    }

    return results;
  }
}
