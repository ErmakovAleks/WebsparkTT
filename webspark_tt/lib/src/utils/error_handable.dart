import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

mixin ErrorHandable {
  void showAlertDialog(BuildContext context, String title, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }
}