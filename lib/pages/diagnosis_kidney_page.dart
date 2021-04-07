import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/pages/main_template.dart';
import '../constants.dart';
import 'registration/sign_btn.dart';

class DiagnosisKidneyPage extends StatefulWidget {
  static const String routeName = 'diagnosisKidneyPage';

  @override
  _DiagnosisKidneyPageState createState() => _DiagnosisKidneyPageState();
}

class _DiagnosisKidneyPageState extends State<DiagnosisKidneyPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var val = 0;
  double result;
  String resultData, weight, age;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MainTemplate(
      isHome: false,
      title: 'تشخيص الفشل الكلوى',
      child: NotificationListener(
        onNotification: (OverscrollIndicatorNotification notification) {
          notification.disallowGlow();
          return;
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).accentColor,
                        Constants.color2,
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$resultData',
                      style: GoogleFonts.elMessiri(
                        fontSize: 16,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45)
                            .copyWith(top: 20),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'ادخل وزنك',
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
                              return 'من فضلك ادخل وزنك';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              weight = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45)
                            .copyWith(top: 20),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'ادخل عمرك',
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
                              return 'من فضلك ادخل عمرك';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              age = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*--------------------  1st Radio  --------------------*/
                    Radio(
                      value: 1,
                      toggleable: true,
                      groupValue: val,
                      onChanged: (value) {
                        setState(
                          () {
                            val = value;
                          },
                        );
                      },
                    ),
                    Text(
                      "ذكر",
                      style: GoogleFonts.elMessiri(
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 35),
                    /*--------------------  3rd Radio  --------------------*/
                    Radio(
                      value: 2,
                      toggleable: true,
                      groupValue: val,
                      onChanged: (value) {
                        setState(
                          () {
                            val = value;
                          },
                        );
                      },
                    ),
                    Text(
                      "انثى",
                      style: GoogleFonts.elMessiri(
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: size.width * 0.4,
                  child: SignBtn(
                    text: 'احسب',
                    onClicked: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (val == 0) {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: Text('من فضلك اختر نوع الجنس'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          );
                        } else if (val == 1) {
                          setState(() {
                            result = ((140 - double.parse(age)) *
                                    double.parse(weight)) *
                                72;
                            resultData = result.toStringAsFixed(2);
                          });
                        } else {
                          setState(() {
                            result = ((140 - double.parse(age)) *
                                    double.parse(weight) *
                                    0.58) *
                                72;
                            resultData = result.toStringAsFixed(2);
                          });
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
