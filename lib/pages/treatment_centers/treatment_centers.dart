import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/widgets/clippers.dart';
import 'package:medical_app/widgets/drawer.dart';

import '../../constants.dart';
import 'treatment_details_page.dart';

class TreatmentCenter extends StatelessWidget {
  static const String routeName = 'treatmentCenter';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 120, right: 25),
            color: Constants.textFieldColor,
            alignment: Alignment.topRight,
            child: Text(
              'مراكز الفشل الكلوى',
              style: GoogleFonts.elMessiri(
                fontSize: Theme.of(context).textTheme.headline5.fontSize,
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
                  collapsedHeight: 200,
                  expandedHeight: 200,
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
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pushNamed(
                                      TreatmentDetailsPage.routeName),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          width: size.width * 0.3,
                                          height: size.width * 0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            color: Colors.white,
                                          ),
                                          child: Image.asset(
                                            'assets/treatment.png',
                                            matchTextDirection: true,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'مركز الحياه',
                                              style: GoogleFonts.elMessiri(
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .fontSize,
                                                  color: Constants.darkColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              'مركز لعلاج الفشل الكلوى',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.elMessiri(
                                                  color: Colors.grey.shade700),
                                            ),
                                            Text(
                                              '12 ص : 4 م',
                                              style: GoogleFonts.elMessiri(
                                                  color: Colors.grey.shade700),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber[700]),
                                            const SizedBox(width: 3),
                                            const Text('4.6'),
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
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
}
