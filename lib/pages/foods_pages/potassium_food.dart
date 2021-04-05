import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/widgets/clippers.dart';
import 'package:medical_app/widgets/drawer.dart';

import '../../constants.dart';

class PotassiumFood extends StatelessWidget {
  static const String routeName = 'potassiumFood';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 100, right: 25),
            color: Constants.textFieldColor,
            alignment: Alignment.topRight,
            child: Text(
              'أغذية غنية بالبوتاسيوم',
              style: GoogleFonts.elMessiri(
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
                color: Constants.darkColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Positioned(
            top: -(size.height * 0.18),
            left: -(size.width * 0.45),
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
                  collapsedHeight: 130,
                  expandedHeight: 130,
                  actions: [
                    IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.menu_rounded),
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headline('خضروات غنية بالبوتاسيوم', context),
                            ...List.generate(
                              Constants.potassiumVegets.length,
                              (index) => Text(
                                Constants.potassiumVegets[index],
                                style: GoogleFonts.elMessiri(
                                    height: 1.7,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .fontSize,
                                    color: Constants.darkColor),
                              ),
                            ),
                            const SizedBox(height: 10),
                            headline('فواكه غنية بالبوتاسيوم', context),
                            ...List.generate(
                              Constants.potassiumFriuts.length,
                              (index) => Text(
                                Constants.potassiumFriuts[index],
                                style: GoogleFonts.elMessiri(
                                    height: 1.7,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .fontSize,
                                    color: Constants.darkColor),
                              ),
                            ),
                            const SizedBox(height: 10),
                            headline('أغذية اخرى غنية بالبوتاسيوم', context),
                            ...List.generate(
                              Constants.otherPotassiumFoods.length,
                              (index) => Text(
                                Constants.otherPotassiumFoods[index],
                                style: GoogleFonts.elMessiri(
                                    height: 1.7,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .fontSize,
                                    color: Constants.darkColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }

  headline(text, context) {
    return Text(
      text,
      style: GoogleFonts.elMessiri(
          fontSize: Theme.of(context).textTheme.headline6.fontSize,
          color: Constants.darkColor,
          fontWeight: FontWeight.bold),
    );
  }
}
