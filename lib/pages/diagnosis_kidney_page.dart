import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_app/widgets/global_btn.dart';
import 'package:medical_app/widgets/main_template.dart';
import '../constants.dart';

class DiagnosisKidneyPage extends StatefulWidget {
  static const String routeName = 'diagnosisKidneyPage';

  @override
  _DiagnosisKidneyPageState createState() => _DiagnosisKidneyPageState();
}

class _DiagnosisKidneyPageState extends State<DiagnosisKidneyPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  var val = 0;
  double result;
  String protien = '';
  String level = '';
  String resultData = 'تشخيص الفشل الكلوى', weight, age, keratin;
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
                  width: size.width * 0.44,
                  height: size.width * 0.44,
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 800),
                      reverseDuration: const Duration(milliseconds: 800),
                      alignment: Alignment.center,
                      firstCurve: Curves.easeInOutBack,
                      secondCurve: Curves.easeInOutBack,
                      crossFadeState: crossFadeState,
                      firstChild: Text(
                        '$resultData',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Constants.darkColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.fontName,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      secondChild: Text(
                        'انت فى $level نسبة البروتين التى يحتاجها جسمك $protien باليوم',
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: Constants.darkColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.fontName,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
/*------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Weight TextField  -----------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45)
                            .copyWith(top: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
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
/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Age TextField  -------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45)
                            .copyWith(top: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
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
/*------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Keratin TextField  ----------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45)
                            .copyWith(top: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'ادخل الكرياتين',
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
                              return 'من فضلك ادخل الكرياتين';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              keratin = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                      style: const TextStyle(
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.fontName,
                      ),
                    ),
                    const SizedBox(width: 35),
                    /*--------------------  2nd Radio  --------------------*/
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
                      style: const TextStyle(
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.fontName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
/*------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Calculate Button  -----------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                GlobalBtn(
                  text: 'احسب',
                  width: size.width * 0.4,
                  onClicked: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (val == 0) {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: const Text('من فضلك اختر نوع الجنس'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      } else if (val == 1) {
                        setState(() {
                          result = ((140 - double.parse(age)) *
                                  double.parse(weight)) /
                              (double.parse(keratin) * 72);
                          showInfo(result);
                          crossFadeState = CrossFadeState.showSecond;
                        });
                        Timer(const Duration(seconds: 3), () {
                          setState(
                              () => crossFadeState = CrossFadeState.showFirst);
                        });
                      } else {
                        setState(() {
                          result = ((140 - double.parse(age)) *
                                  double.parse(weight) *
                                  0.58) /
                              (double.parse(keratin) * 72);
                          showInfo(result);
                          crossFadeState = CrossFadeState.showSecond;
                        });
                        Timer(const Duration(seconds: 3), () {
                          setState(
                              () => crossFadeState = CrossFadeState.showFirst);
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*------------------------------------------------------------------------------------------------------*/
/*-------------------------------------  Show Results Info Func.  --------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
  showInfo(result) {
    if (result < 15) {
      // setState(() {
      protien = '1.2-1.3 جرام';
      level = 'المرحلة الخامسة';
      // });
    } else if (result >= 15 && result < 30) {
      // setState(() {
      protien = '0.5-0.6 جرام';
      level = 'المرحلة الرابعة';
      // });
    } else if (result >= 30 && result < 60) {
      // setState(() {
      protien = '0.5-0.6 جرام';
      level = 'المرحلة الثالثة';
      // });
    } else if (result >= 60 && result < 90) {
      // setState(() {
      protien = '0.8-1 جرام';
      level = 'المرحلة الثانية';
      // });
    } else if (result >= 90) {
      // setState(() {
      protien = '0.8-1 جرام';
      level = 'المرحلة الاولى';
      // });
    }
  }
}
