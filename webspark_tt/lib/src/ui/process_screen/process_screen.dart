import 'package:flutter/material.dart';
import 'package:webspark_tt/src/ui/process_screen/process_screen_view_model.dart';
import 'package:webspark_tt/src/widgets/primary_button.dart';

class ProcessScreen extends StatefulWidget {
  final ProcessScreenViewModel viewModel;

  const ProcessScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<ProcessScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text(
        'Process screen',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue,
      centerTitle: false,
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const Text(
            'All calculations have finished, you can send your results to the server',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          StreamBuilder(
            stream: widget.viewModel.progress,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Text(
                    '${(widget.viewModel.progress.value * 100).ceil()}%', // Отображение процентов
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: Colors.red,
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: widget.viewModel.progress.value,
                      strokeWidth: 6,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              );
            },
          ),
          const Spacer(),
          PrimaryButton(title: 'Send results to server', action: () {})
        ],
      ),
    );
  }
}
