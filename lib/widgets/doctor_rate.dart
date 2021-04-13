import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/models/doctor_model.dart';

import '../constants.dart';

class DoctorRate extends StatefulWidget {
  final DoctorModel doctorModel;

  const DoctorRate({Key key, this.doctorModel}) : super(key: key);
  @override
  _DoctorRateState createState() => _DoctorRateState();
}

class _DoctorRateState extends State<DoctorRate> {
  double rate;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    rate = widget.doctorModel.rate ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              'التقييم',
              style: GoogleFonts.elMessiri(
                color: Constants.darkColor,
              ),
            ),
            content: Form(
              key: formKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'ادخل التقييم',
                  filled: true,
                  fillColor: Constants.textFieldColor,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'من فضلك ادخل تقييمك';
                  } else if (double.parse(value) > 10 ||
                      double.parse(value) < 0) {
                    return 'ادخل تقييم من 0 الى 10';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  setState(() {
                    rate = double.parse(newValue);
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    DoctorsDB().updateData(DoctorModel(
                      rate: rate,
                      id: widget.doctorModel.id,
                      name: widget.doctorModel.name,
                      email: widget.doctorModel.email,
                      phoneNumber: widget.doctorModel.phoneNumber,
                      username: widget.doctorModel.username,
                      workSpace: widget.doctorModel.workSpace,
                    ));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('قيم'),
              ),
            ],
          ),
        );
      },
      label: const Text('تقييم'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
