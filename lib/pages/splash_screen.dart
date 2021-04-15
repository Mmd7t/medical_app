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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -(size.height * 0.18),
            left: -(size.width * 0.45),
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).accentColor,
                      Constants.color2,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -(size.height * 0.18),
            right: -(size.width * 0.45),
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).accentColor,
                      Constants.color2,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/app_logo.png', width: size.width * 0.5),
                Text(
                  Constants.appName,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Constants.darkColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constants.fontName,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
