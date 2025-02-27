import 'package:flutter/material.dart';
import 'package:webspark_tt/src/models/models.dart';
import 'package:webspark_tt/src/routes/router.dart';

class ResultsScreenViewModel {
  final List<CompletedTask> completedTasks;

  ResultsScreenViewModel({required this.completedTasks});

  void buttonTapped(BuildContext context, CompletedTask task) {
    if (context.mounted) {
      Navigator.of(context).pushNamed(AppRouteKeys.preview, arguments: task);
    }
  }
}