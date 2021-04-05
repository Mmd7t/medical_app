import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProvider extends ChangeNotifier {
  bool _isDoctor = false;

  bool get doctor => _isDoctor;
  SharedPreferences _prefs;

  DoctorProvider() {
    _loadPrefs();
  }

  switchDoctor() {
    _isDoctor = !_isDoctor;
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
    _prefs.setBool('doctor', _isDoctor);
  }

  _loadPrefs() async {
    await initPrefs();
    _isDoctor = _prefs.getBool('doctor') ?? false;
    notifyListeners();
  }
}
