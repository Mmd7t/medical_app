import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';

import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = 'splash';
  final initScreen;

  const SplashScreen({Key key, this.initScreen}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacementNamed(
          LandingPage.routeName,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Constants.appName),
      ),
    );
  }
}
