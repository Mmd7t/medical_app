import 'package:flutter/material.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/providers/israted_provider.dart';
import 'package:medical_app/providers/num_of_rates_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class DoctorRate extends StatefulWidget {
  final DoctorModel doctorModel;

  const DoctorRate({Key key, this.doctorModel}) : super(key: key);
  @override
  _DoctorRateState createState() => _DoctorRateState();
}

class _DoctorRateState extends State<DoctorRate> {
  double rateValue, ratesResult;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    rateValue = widget.doctorModel.rate ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    var numOfRates = Provider.of<NumOfRateProvider>(context);
    var checkRating = Provider.of<IsRatedProvider>(context);
    return FloatingActionButton.extended(
      onPressed: () {
        ratingDialog(context, numOfRates, checkRating);
      },
      label: const Text('تقييم'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

/*---------------------------------------------------------------------------------------------*/
/*--------------------------------------  Rating Dialog  --------------------------------------*/
/*---------------------------------------------------------------------------------------------*/

  ratingDialog(context, numOfRates, IsRatedProvider checkRating) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'التقييم',
          style: const TextStyle(
              color: Constants.darkColor, fontFamily: Constants.fontName),
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'ادخل تقييمك من 0 الى 10',
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
              } else if (double.parse(value) > 10 || double.parse(value) < 0) {
                return 'ادخل تقييم من 0 الى 10';
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              setState(() {
                rateValue = double.parse(newValue);
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
                numOfRates.setNumOfRates(widget.doctorModel.numOfRates + 1);
                setState(() {
                  ratesResult = ((widget.doctorModel.rate) + rateValue) /
                      numOfRates.numOfRates;
                });
                DoctorsDB().updateData(DoctorModel(
                  rate: ratesResult,
                  numOfRates: numOfRates.numOfRates,
                  id: widget.doctorModel.id,
                  name: widget.doctorModel.name,
                  email: widget.doctorModel.email,
                  phoneNumber: widget.doctorModel.phoneNumber,
                  username: widget.doctorModel.username,
                  workSpace: widget.doctorModel.workSpace,
                  token: widget.doctorModel.token,
                ));

                // checkRating.switchRated();

                Navigator.of(context).pop();
              }
            },
            child: const Text('قيم'),
          ),
        ],
      ),
    );
  }
}
