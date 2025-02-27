import 'package:flutter/material.dart';
import 'package:webspark_tt/src/constants/colors.dart';
import 'package:webspark_tt/src/models/models.dart';
import 'package:webspark_tt/src/ui/preview_screen/preview_screen_view_model.dart';
import 'package:webspark_tt/src/widgets/custom_app_bar.dart';

class PreviewScreen extends StatelessWidget {
  final PreviewScreenViewModel viewModel;

  const PreviewScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Preview screen'),
      body: _body(),
    );
  }

  Widget _body() {
    List<List<String>> grid = viewModel.task.task.field.map((row) => row.split('')).toList();
    int rows = grid.length;
    int cols = grid.first.length;

    return Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                childAspectRatio: 1,
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                int x = index ~/ cols;
                int y = index % cols;
                Point point = Point(x: x, y: y);

                return Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: viewModel.getCellColor(grid, point),
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: Center(
                    child: Text(
                      point.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: viewModel.getTextColor(grid, point),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                viewModel.task.path,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
    );
  }
}
