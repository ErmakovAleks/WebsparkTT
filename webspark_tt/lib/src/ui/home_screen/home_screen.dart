import 'package:flutter/material.dart';
import 'package:webspark_tt/src/ui/home_screen/home_screen_view_model.dart';
import 'package:webspark_tt/src/widgets/primary_button.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenViewModel viewModel;

  const HomeScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        'Home screen',
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
    return StreamBuilder<bool>(
        stream: widget.viewModel.isLoading,
        builder: (context, snapshot) {
          return Stack(
            children: [
              _content(),
              if (snapshot.data ?? true) const Center(child: CircularProgressIndicator())
            ],
          );
        });
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set valid API base URL in order to continue',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.compare_arrows),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.viewModel.controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          PrimaryButton(
              title: 'Start counting process',
              action: () {
                widget.viewModel.buttonTapped(context);
              })
        ],
      ),
    );
  }
}
