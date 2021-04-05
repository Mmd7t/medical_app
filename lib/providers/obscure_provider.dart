import 'package:flutter/widgets.dart';

class ObscureProvider extends ChangeNotifier {
  bool _obscure1 = true;
  bool _obscure2 = true;

  bool get obscure1 => _obscure1;
  bool get obscure2 => _obscure2;

  switchObscure1() {
    _obscure1 = !_obscure1;
    notifyListeners();
  }

  switchObscure2() {
    _obscure2 = !_obscure2;
    notifyListeners();
  }
}
