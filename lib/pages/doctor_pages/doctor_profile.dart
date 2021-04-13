import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/models/doctor_model.dart';
import '../../constants.dart';

class DoctorProfile extends StatelessWidget {
  static const String routeName = 'doctorProfile';
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
            padding: const EdgeInsets.only(top: 10),
            child: Hero(
              tag: 'doctor img',
              child: Image.asset(
                'assets/doctor_1.png',
                matchTextDirection: true,
              ),
            ),
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
          StreamBuilder<DoctorModel>(
              stream: DoctorsDB().getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  DoctorModel doctor = snapshot.data;
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: size.width,
                      height: size.height * 0.7,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Theme.of(context).accentColor,
                              Constants.color2,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'د / ${doctor.name}',
                                  style: GoogleFonts.elMessiri(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .fontSize,
                                    color: Constants.darkColor,
                                    fontWeight: FontWeight.w900,
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
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      (doctor.rate == null)
                                          ? '0.0'
                                          : '${doctor.rate}',
                                      style: TextStyle(
                                        color: Constants.darkColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(Icons.star,
                                        color: Colors.amber[700], size: 28),
                                  ],
                                ),
                                const Text('( 2420  تقييم )'),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'نبذة عن الدكتور',
                              style: GoogleFonts.elMessiri(
                                fontSize: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .fontSize +
                                    2,
                                color: Constants.darkColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'الطبيب كما يُعرف بالاسم الأقل شيوعاً الآسي هو من درس علم الطب ومارسها. وهو يعاين المرضى ويشخص لهم المرض ويصرف لهم وصفة يكتب فيها الدواء. والطبيب بعد تخرجه يمارس الطب العام',
                              style: GoogleFonts.elMessiri(
                                height: 2,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .fontSize,
                                color: Constants.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //     Provider.of<DoctorProvider>(context, listen: false).switchDoctor();
      //     context.read<AuthProvider>().signOut();
      //   },
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //   label: Text('تسجيل خروج'),
      // ),
    );
  }
}
