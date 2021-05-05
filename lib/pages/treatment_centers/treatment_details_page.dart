import 'package:flutter/material.dart';
import 'package:medical_app/pages/treatment_centers/map.dart';
import 'package:url_launcher/url_launcher.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              treatment['name'],
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .fontSize -
                                    3,
                                color: Constants.darkColor,
                                fontWeight: FontWeight.w900,
                                fontFamily: Constants.fontName,
                              ),
                            ),
                            Text(
                              treatment['hospital'],
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .fontSize,
                                color: Colors.grey.shade700,
                                fontFamily: Constants.fontName,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FloatingActionButton(
                              heroTag: 'call',
                              onPressed: () {
                                launch('tel:${treatment['phoneNum']}');
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.green,
                              child: const Icon(Icons.call_outlined),
                            ),
                            const SizedBox(width: 8),
                            FloatingActionButton(
                              heroTag: 'position',
                              onPressed: () => Navigator.of(context).pushNamed(
                                  MapPage.routeName,
                                  arguments: index),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Theme.of(context).accentColor,
                              child: const Icon(Icons.pin_drop_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ساعات العمل : ${treatment['workTime']}',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize + 2,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w800,
                        fontFamily: Constants.fontName,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'رقم الهاتف : ${treatment['phoneNum']}',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            height: 2,
                            color: Theme.of(context).accentColor,
                            fontFamily: Constants.fontName,
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
