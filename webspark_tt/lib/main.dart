import 'package:flutter/material.dart';
import 'package:webspark_tt/src/routes/router.dart';
import 'package:webspark_tt/src/utils/shared_preferences_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesWrapper.processInitialize();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webspark TT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: AppRouteKeys.home,
      onGenerateRoute: AppRouter,
    );
  }
}
