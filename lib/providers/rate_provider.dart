import 'package:flutter/cupertino.dart';

class RateProvider extends ChangeNotifier {
  double _val = 0;

  double get val => _val;

  void setRateValue(value) {
    _val = value;
    notifyListeners();
  }
}
