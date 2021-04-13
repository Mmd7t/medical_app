import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class ProfileTemplate extends StatelessWidget {
  final String name;
  final String rate;
  final Function onTap;
  final UserType userType;
  final bool isDoctorProfile;
  final Widget fab;
  final String phoneNum;
  final String workSpace;

  const ProfileTemplate.doctor({
    this.name,
    this.rate,
    this.onTap,
    this.isDoctorProfile = false,
    this.fab,
    this.phoneNum,
    this.workSpace,
  }) : userType = UserType.doctor;

  const ProfileTemplate.patient({
    this.name,
    this.rate,
    this.onTap,
    this.isDoctorProfile = false,
    this.fab,
    this.phoneNum,
    this.workSpace,
  }) : userType = UserType.patient;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
/*---------------------------------------------------------------------------------------*/
/*---------------------------------------  Image  ---------------------------------------*/
/*---------------------------------------------------------------------------------------*/
          Container(
            width: size.width,
            height: size.height / 2,
            color: Constants.textFieldColor,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 15),
            child: Hero(
              tag: 'doctor img',
              child: Image.asset(
                (userType == UserType.doctor)
                    ? 'assets/doctor_1.png'
                    : 'assets/patient_1.png',
                matchTextDirection: true,
                width: (userType == UserType.doctor)
                    ? size.width
                    : size.width * 0.7,
              ),
            ),
          ),
/*---------------------------------------------------------------------------------------*/
/*-------------------------------------  BackButton  ------------------------------------*/
/*---------------------------------------------------------------------------------------*/
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
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Constants.color2,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
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
                                (userType == UserType.doctor)
                                    ? 'د / $name'
                                    : name,
                                style: GoogleFonts.elMessiri(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .fontSize,
                                  color: Constants.darkColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              (userType == UserType.doctor)
                                  ? 'اخصائى جراحة'
                                  : 'فشل كلوى',
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
                        (isDoctorProfile)
                            ? const SizedBox()
                            : Row(
                                children: [
                                  FloatingActionButton(
                                    heroTag: 'call',
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: Colors.green,
                                    child: const Icon(Icons.call_outlined),
                                  ),
                                  const SizedBox(width: 10),
                                  FloatingActionButton(
                                    heroTag: 'chat',
                                    onPressed: onTap,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    child: const Icon(Icons.messenger_rounded),
                                  ),
                                ],
                              ),
                      ],
                    ),
/*---------------------------------------------------------------------------------------*/
/*---------------------------------------  Rate  ----------------------------------------*/
/*---------------------------------------------------------------------------------------*/
                    const SizedBox(height: 20),
                    (userType == UserType.doctor)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (isDoctorProfile)
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          rate,
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
                              const SizedBox(width: 40),
                              const Text('( 2420  تقييم )'),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 30),
                    Text(
                      (userType == UserType.doctor)
                          ? 'مقر العمل : $workSpace'
                          : 'نبذة عن المريض',
                      style: GoogleFonts.elMessiri(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize + 2,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      (userType == UserType.doctor)
                          ? 'رقم الهاتف : $phoneNum'
                          : 'المريض يعانى من الم فى المعدة و احيانا يشغر بالغثيان و القيئ',
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
      floatingActionButton:
          (userType == UserType.doctor) ? fab : const SizedBox(),
    );
  }
}
