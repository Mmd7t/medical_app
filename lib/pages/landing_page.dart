import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:provider/provider.dart';
import 'doctor_pages/doctor_home.dart';
import 'registration/registration.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = 'landingPage';
  @override
  Widget build(BuildContext context) {
    var isDoctor = Provider.of<DoctorProvider>(context);
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      if (isDoctor.doctor) {
        return DoctorHome();
      }
      return Home();
    }
    return Registration();
  }
}
