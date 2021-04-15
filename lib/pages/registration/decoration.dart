import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';

class DecorationSector extends StatelessWidget {
  final Widget btn;

  const DecorationSector({Key key, this.btn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.475,
      child: Stack(
        children: [
          ClipPath(
            clipper: _MyClipper(),
            child: Container(
              width: size.width,
              height: size.height * 0.475,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Constants.color2,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: _MyClipper(),
            child: Container(
              width: size.width,
              height: size.height * 0.45,
              color: Constants.textFieldColor,
              alignment: Alignment.center,
              child: Text(
                Constants.appName,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Constants.darkColor,
                      fontWeight: FontWeight.w900,
                      fontFamily: Constants.fontName,
                    ),
              ),
            ),
          ),
          Positioned(
            top: -(size.height * 0.15),
            left: -(size.width * 0.42),
            child: ClipOval(
              child: Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).accentColor,
                      Constants.color2,
                    ],
                    begin: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 40,
            child: btn,
          ),
        ],
      ),
    );
  }
}

/*-----------------------------------------------------------------------------------*/
/*------------------------------------  Clipper  ------------------------------------*/
/*-----------------------------------------------------------------------------------*/
class _MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var x = size.width;
    var y = size.height;
    path.lineTo(0, y * 0.7);
    path.quadraticBezierTo(x * 0.25, y * 0.6, x * 0.5, y * 0.8);
    path.quadraticBezierTo(x * 0.75, y, x, y * 0.9);
    path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
