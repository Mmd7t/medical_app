import 'package:flutter/material.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/pages/doctor_pages/doctor_messages.dart';
import 'package:medical_app/pages/doctor_pages/doctor_profile.dart';
import 'package:medical_app/pages/treatment_centers/treatment_centers.dart';
import 'package:medical_app/providers/auth_provider.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class DoctorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            StreamBuilder<DoctorModel>(
                stream: DoctorsDB().getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    DoctorModel doctor = snapshot.data;
                    return Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).accentColor,
                                Constants.color2,
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60))),
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                            color: Constants.textFieldColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(60))),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Constants.textFieldColor,
                          backgroundImage: AssetImage('assets/app_logo.png'),
                        ),
                        accountName: Text(doctor.name),
                        accountEmail: Text(doctor.email),
                      ),
                    );
                  }
                }),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(TreatmentCenter.routeName),
              title: const Text("مراكز العلاج"),
              leading: Icon(
                Icons.local_hospital_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            StreamBuilder<DoctorModel>(
              stream: DoctorsDB().getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  DoctorModel doctor = snapshot.data;
                  return ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DoctorMessages(userName: doctor.username))),
                    title: const Text("الرسائل"),
                    leading: Icon(
                      Icons.message_outlined,
                      color: Theme.of(context).accentColor,
                    ),
                  );
                }
              },
            ),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(DoctorProfile.routeName),
              title: const Text("بياناتى"),
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            Divider(
              height: 10,
              color: Theme.of(context).primaryColor,
              endIndent: 30,
              indent: 30,
            ),
            ListTile(
              onTap: () {
                Provider.of<DoctorProvider>(context, listen: false)
                    .switchDoctor();
                context.read<AuthProvider>().signOut();
              },
              title: const Text("تسجيل الخروج"),
              leading: Icon(
                Icons.exit_to_app_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
