import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/pages/main_template.dart';

import '../constants.dart';
import 'registration/sign_btn.dart';

class CalculateWaterPage extends StatefulWidget {
  static const String routeName = 'calculateWaterPage';

  @override
  _CalculateWaterPageState createState() => _CalculateWaterPageState();
}

class _CalculateWaterPageState extends State<CalculateWaterPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String water = 'حساب عدد أكواب الماء';
  String weight;
  double result = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MainTemplate(
      isHome: false,
      title: 'حساب شرب الماء',
      child: Center(
        child: NotificationListener(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowGlow();
            return;
          },
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
                      water,
                      style: GoogleFonts.elMessiri(
                        fontSize: 16,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------  TextField  -----------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45)
                      .copyWith(top: 30),
                  child: Form(
                    key: _formKey,
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
                ),
/*-----------------------------------------------------------------------------------------------*/
/*------------------------------------------  Button  -------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/
                const SizedBox(height: 40),
                Container(
                  width: size.width * 0.4,
                  child: SignBtn(
                    text: 'احسب',
                    onClicked: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        setState(() {
                          result = (30 * double.parse(weight)) / 250;
                          water = result.toStringAsFixed(2);
                        });
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
