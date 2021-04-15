import 'package:flutter/material.dart';
import 'package:medical_app/widgets/clippers.dart';
import 'package:medical_app/widgets/doctor_drawer.dart';
import 'package:medical_app/widgets/patient_drawer.dart';
import '../constants.dart';

class MainTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isHome;
  final UserType userType;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainTemplate({
    Key key,
    this.title,
    this.child,
    this.isHome,
    this.userType = UserType.patient,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: (isHome) ? 120 : 100, right: 25),
            color: Constants.textFieldColor,
            alignment: Alignment.topRight,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Constants.darkColor,
                    fontWeight: FontWeight.w900,
                    fontFamily: Constants.fontName,
                  ),
            ),
          ),
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
          NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  collapsedHeight: (isHome) ? 200 : 150,
                  expandedHeight: (isHome) ? 200 : 150,
                  actions: [
                    IconButton(
                      color: Colors.white,
                      icon: (isHome)
                          ? const Icon(Icons.menu_rounded)
                          : const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: (isHome)
                          ? () => _scaffoldKey.currentState.openDrawer()
                          : () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ];
            },
            body: ClipPath(
              clipper: MyClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).accentColor,
                    Constants.color2,
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
                padding: const EdgeInsets.only(top: 10),
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    color: Colors.white,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: (userType == UserType.patient) ? PatientDrawer() : DoctorDrawer(),
    );
  }
}
