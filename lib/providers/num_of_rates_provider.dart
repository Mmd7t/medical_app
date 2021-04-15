import 'package:flutter/cupertino.dart';

class NumOfRateProvider extends ChangeNotifier {
  int _numOfRates = 0;

  int get numOfRates => _numOfRates;

  setNumOfRates(value) {
    _numOfRates = value;
    notifyListeners();
  }
}
