import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsRatedProvider extends ChangeNotifier {
  bool _isRated = false;

  bool get isRated => _isRated;
  SharedPreferences _prefs;

  IsRatedProvider() {
    _loadPrefs();
  }

  switchRated() {
    _isRated = !_isRated;
    _savePrefs();
    notifyListeners();
  }

  initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  _savePrefs() async {
    await initPrefs();
    _prefs.setBool('rate', _isRated);
  }

  _loadPrefs() async {
    await initPrefs();
    _isRated = _prefs.getBool('rate') ?? false;
    notifyListeners();
  }
}
