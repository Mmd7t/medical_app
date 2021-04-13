import 'package:flutter/material.dart';

class RateProvider extends ChangeNotifier {
  double _rate = 0.0;

  double get rate => _rate;

  setRate(value) {
    _rate = value;
  }
}
