import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  static late SharedPreferences _container; 

  static processInitialize() async {
    _container = await SharedPreferences.getInstance();
  }

  static Future<bool> setURL(String url) {
    return _container.setString('savedUrl', url);
  }

  static String? getURL() {
    return _container.getString('savedUrl');
  }
}