import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class TreatmentDetailsPage extends StatelessWidget {
  static const String routeName = 'treatmentDetailsPage';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var index = ModalRoute.of(context).settings.arguments;
    var treatment = Constants.treatmentCenters[index];
    return Scaffold(
      body: Stack(
        children: [
          Container(width: double.infinity, height: double.infinity),
          Container(
            width: size.width,
            height: size.height / 2,
            color: Constants.textFieldColor,
            alignment: Alignment.topRight,
            child: Image.asset('assets/treatment.png'),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  color: Theme.of(context).accentColor,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              width: size.width,
              height: size.height * 0.7,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).accentColor,
                  Constants.color2,
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
              ),
              child: Container(
                width: size.width,
                height: size.height * 0.7,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                treatment['name'],
                                style: GoogleFonts.elMessiri(
                                  fontSize: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .fontSize -
                                      3,
                                  color: Constants.darkColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                treatment['hospital'],
                                style: GoogleFonts.elMessiri(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .fontSize,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: 'call',
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.call_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ساعات العمل : ${treatment['workTime']}',
                      style: GoogleFonts.elMessiri(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize + 2,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'رقم الهاتف : ${treatment['phoneNum']}',
                      style: GoogleFonts.elMessiri(
                        height: 2,
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
