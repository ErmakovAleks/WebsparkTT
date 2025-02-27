import 'package:flutter/material.dart';
import 'package:webspark_tt/src/ui/results_screen/results_screen_view_model.dart';
import 'package:webspark_tt/src/widgets/custom_app_bar.dart';

class ResultsScreen extends StatelessWidget {
  final ResultsScreenViewModel viewModel;

  const ResultsScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Result list screen'),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView.separated(
        itemCount: viewModel.completedTasks.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              viewModel.completedTasks[index].path,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              viewModel.buttonTapped(context, viewModel.completedTasks[index]);
            },
          );
        },
      );
  }
}