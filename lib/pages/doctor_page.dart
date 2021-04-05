import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/constants.dart';

import 'messages/chat_page.dart';

class DoctorPage extends StatelessWidget {
  static const String routeName = 'doctorPage';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(width: double.infinity, height: double.infinity),
          Container(
            width: size.width,
            height: size.height / 2,
            color: Constants.textFieldColor,
            alignment: Alignment.topRight,
            child: Hero(
              tag: 'doctor img',
              child: Image.asset(
                'assets/doctor_1.png',
                matchTextDirection: true,
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: 'doctor name',
                              child: Text(
                                'د / محمد ماهر',
                                style: GoogleFonts.elMessiri(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .fontSize,
                                  color: Constants.darkColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              'اخصائى جراحة',
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
                        Row(
                          children: [
                            FloatingActionButton(
                              heroTag: 'call',
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.green,
                              child: const Icon(Icons.call_outlined),
                            ),
                            const SizedBox(width: 10),
                            FloatingActionButton(
                              heroTag: 'chat',
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(ChatPage.routeName),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Theme.of(context).accentColor,
                              child: const Icon(Icons.messenger_rounded),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: (index == 4)
                                  ? Constants.darkColor.withOpacity(0.4)
                                  : Colors.amber[700],
                            ),
                          ),
                        ),
                        const Text('( 2420  تقييم )'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'نبذة عن الدكتور',
                      style: GoogleFonts.elMessiri(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize + 2,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'الطبيب كما يُعرف بالاسم الأقل شيوعاً الآسي هو من درس علم الطب ومارسها. وهو يعاين المرضى ويشخص لهم المرض ويصرف لهم وصفة يكتب فيها الدواء. والطبيب بعد تخرجه يمارس الطب العام',
                      style: GoogleFonts.elMessiri(
                        height: 2,
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize,
                        color: Constants.darkColor,
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
