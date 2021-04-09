import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static SharedPreferences prefs;
  static initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  static saveToPrefs(String key, String value) async {
    await initPrefs();
    prefs.setString(key, value);
  }

  static getFromPrefs(String key) async {
    await initPrefs();
    String savedValue = prefs.getString(key) ?? '';
    return savedValue;
  }
}
