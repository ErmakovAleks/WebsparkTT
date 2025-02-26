import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webspark_tt/src/API/api_provider.dart';
import 'package:webspark_tt/src/ui/home_screen/home_screen.dart';
import 'package:webspark_tt/src/ui/home_screen/home_screen_view_model.dart';
import 'package:webspark_tt/src/ui/process_screen/process_screen.dart';
import 'package:webspark_tt/src/ui/process_screen/process_screen_view_model.dart';
import 'package:webspark_tt/src/utils/grid_navigator.dart';

abstract class AppRouteKeys {
  static const String home = 'home';
  static const String process = 'process';
  static const String resultList = 'resultList';
  static const String preview = 'preview';
}

// ignore: body_might_complete_normally_nullable, non_constant_identifier_names
Route<dynamic>? AppRouter(RouteSettings settings) {
  final provider = ApiProvider();
  switch (settings.name) {
    case AppRouteKeys.home:
      return nativePageRoute(
        settings: settings,
        builder: (context) {
          final viewModel = HomeScreenViewModel(provider: provider);
          return HomeScreen(viewModel: viewModel);
        },
      );
    case AppRouteKeys.process:
      return nativePageRoute(
        settings: settings,
        builder: (context) {
          final taskList = settings.arguments as TaskList;
          final gridNavigator = GridNavigator();
          final viewModel = ProcessScreenViewModel(provider: provider);
          return ProcessScreen(viewModel: viewModel);
        },
      );
  }
}

PageRoute<T>? nativePageRoute<T>({
  required WidgetBuilder builder,
  required RouteSettings settings,
}) {
  if (Platform.isAndroid) {
    return MaterialPageRoute<T>(
      builder: builder,
      settings: settings,
    );
  } else {
    return CupertinoPageRoute<T>(
      builder: builder,
      settings: settings,
    );
  }
}
