import 'package:flutter/material.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/widgets/profile_template.dart';

class DoctorProfile extends StatelessWidget {
  static const String routeName = 'doctorProfile';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DoctorModel>(
      stream: DoctorsDB().getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          DoctorModel doctor = snapshot.data;
          return ProfileTemplate.doctor(
            isDoctorProfile: true,
            name: doctor.name,
            phoneNum: doctor.phoneNumber,
            workSpace: doctor.workSpace,
          );
        }
      },
    );
  }
}
