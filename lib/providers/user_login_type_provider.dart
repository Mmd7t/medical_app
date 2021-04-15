import 'package:flutter/cupertino.dart';

import '../constants.dart';

class UserLoginTypeProvider extends ChangeNotifier {
  AuthUserState _authUserState = AuthUserState.patient;

  AuthUserState get authUserState => _authUserState;

  setAuthState(value) {
    _authUserState = value;
    notifyListeners();
  }
}
