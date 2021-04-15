import 'package:flutter/material.dart';
import 'package:medical_app/pages/registration/login_form.dart';
import 'decoration.dart';
import 'signup_form.dart';

enum RegistrationType { login, signup }

class Registration extends StatefulWidget {
  static const String routeName = 'registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String btnText = 'تسجيل دخول';

  var _type = RegistrationType.signup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecorationSector(
              btn: TextButton(
                onPressed: () {
                  if (_type == RegistrationType.login) {
                    setState(() {
                      _type = RegistrationType.signup;
                      btnText = 'تسجيل دخول';
                    });
                  } else {
                    setState(() {
                      _type = RegistrationType.login;
                      btnText = 'حساب جديد';
                    });
                  }
                },
                child: Text(btnText),
              ),
            ),
            _registerationBox(context),
          ],
        ),
      ),
    );
  }

/*-----------------------------------------------------------------------------------*/
/*-------------------------------  Registeration Box  -------------------------------*/
/*-----------------------------------------------------------------------------------*/

  _registerationBox(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: (_type == RegistrationType.login) ? LoginForm() : SignupForm(),
    );
  }
}
