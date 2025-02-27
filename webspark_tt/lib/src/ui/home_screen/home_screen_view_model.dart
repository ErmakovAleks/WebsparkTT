import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:webspark_tt/src/API/api_provider.dart';
import 'package:webspark_tt/src/routes/router.dart';
import 'package:webspark_tt/src/utils/error_handable.dart';
import 'package:webspark_tt/src/utils/shared_preferences_wrapper.dart';

class HomeScreenViewModel with ErrorHandable {
  final ApiProvider _provider;
  final TextEditingController controller = TextEditingController();
  final isLoading = BehaviorSubject<bool>.seeded(false);

  HomeScreenViewModel({required ApiProvider provider}) :_provider = provider {
    controller.text = SharedPreferencesWrapper.getURL() ?? '';
  }

  Future<void> buttonTapped(BuildContext context) async {
    isLoading.add(true);
    final String url;

    if (controller.text.isNotEmpty) {
      await SharedPreferencesWrapper.setURL(controller.text);
      url = controller.text;
    } else if (SharedPreferencesWrapper.getURL() != null) {
      url = SharedPreferencesWrapper.getURL() ?? '';
    } else {
      if (context.mounted) showAlertDialog(context, 'Error', 'URL can\'t be empty');
      return;
    }

    _sendRequest(context, url);
  }

  void _sendRequest(BuildContext context, String stringUrl) async {
    _provider.fetchTasks(stringUrl).then((value) {
      if (context.mounted) Navigator.of(context).pushNamed(AppRouteKeys.process, arguments: value);
      isLoading.add(false);
    }).catchError((error) {
      debugPrint('<!> Request error: $error');
      if (context.mounted) showAlertDialog(context, 'Error', 'Error from server: $error');
      isLoading.add(false);
    });
  }
}