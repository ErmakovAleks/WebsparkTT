import 'package:flutter/material.dart';
import 'package:webspark_tt/src/constants/colors.dart';
import 'package:webspark_tt/src/models/models.dart';

class PreviewScreenViewModel {
  final CompletedTask task;

  PreviewScreenViewModel({required this.task});

  Color getCellColor(List<List<String>> grid, Point point) {
    if (point == task.task.start) return AppColors.start;
    if (point == task.task.end) return AppColors.end;
    if (task.path.contains(point.toString())) return AppColors.shortest;
    if (grid[point.x][point.y] == 'X') return AppColors.blocked;
    return AppColors.empty;
  }

  Color getTextColor(List<List<String>> grid, Point point) {
    if (grid[point.x][point.y] == 'X' || task.path.contains(point.toString())) {
      return Colors.white;
    }

    return Colors.black;
  }
}