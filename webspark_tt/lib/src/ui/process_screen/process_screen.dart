import 'package:flutter/material.dart';
import 'package:webspark_tt/src/ui/process_screen/process_screen_view_model.dart';
import 'package:webspark_tt/src/widgets/custom_app_bar.dart';
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.findShortestPaths();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Process screen'),
      body: _body(),
    );
  }

  Widget _body() {
    return StreamBuilder<bool>(
      stream: widget.viewModel.isLoading,
      builder: (context, snapshot) {
        return Stack(
          children: [
            _content(snapshot),
            if (snapshot.data ?? true)
              const Center(child: CircularProgressIndicator())
          ],
        );
      },
    );
  }

  Widget _content(AsyncSnapshot<bool> loadingSnapshot) {
    return StreamBuilder<double>(
      stream: widget.viewModel.progress,
      builder: (context, snapshot) {
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
              Text(
                '${((snapshot.data ?? 0.0) * 100).ceil()}%', // Отображение процентов
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: snapshot.data,
                  strokeWidth: 6,
                  color: Colors.blueAccent,
                ),
              ),
              const Spacer(),
              Visibility(
                visible: ((snapshot.data ?? 0.0) >= 1.0),
                child: PrimaryButton(
                  title: 'Send results to server',
                  action: (loadingSnapshot.data ?? false)
                      ? null
                      : () => widget.viewModel.buttonTapped(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
