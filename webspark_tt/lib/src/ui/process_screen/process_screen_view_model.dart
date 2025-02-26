import 'package:rxdart/subjects.dart';
import 'package:webspark_tt/src/API/api_provider.dart';

class ProcessScreenViewModel {
  final ApiProvider provider;
  final progress = BehaviorSubject<double>.seeded(0.0);

  ProcessScreenViewModel({required this.provider}) {
    _startProgress();
  }

  void _startProgress() async {
    while (progress.value < 0.9) {
      progress.add(progress.value + 0.1);
      await Future.delayed(const Duration(milliseconds: 300)); // Имитация работы
    }
  }
}