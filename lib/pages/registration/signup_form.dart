import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/pages/registration/sign_btn.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:medical_app/providers/auth_provider.dart';
import 'package:medical_app/providers/obscure_provider.dart';
import 'package:medical_app/widgets/global_textfield.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final formKey = GlobalKey<FormState>();
  String email, password, name, username;
  AuthUserState authUserState = AuthUserState.patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
/*------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Name  -----------------------------------------*/
/*------------------------------------------------------------------------------------------*/
            GlobalTextField(
              hint: 'الاسم',
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              prefixIcon: Icons.person_outline,
              borderRadius: 10,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'من فضلك ادخل الاسم';
                }
              },
              onSaved: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            const SizedBox(height: 5),
/*------------------------------------------------------------------------------------------*/
/*--------------------------------------  Phone Num  ---------------------------------------*/
/*------------------------------------------------------------------------------------------*/
            GlobalTextField(
              hint: 'اسم المستخدم',
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              prefixIcon: Icons.person_outline,
              borderRadius: 10,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'من فضلك ادخل اسم المستخدم';
                }
              },
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            const SizedBox(height: 5),
/*------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Email  ----------------------------------------*/
/*------------------------------------------------------------------------------------------*/
            GlobalTextField(
              hint: 'الايميل',
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              borderRadius: 10,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'من فضلك ادخل الايميل';
                } else if (!value.contains('@')) {
                  return 'من فضلك ادخل الايميل بطريقة صحيحة';
                }
              },
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(height: 5),
/*------------------------------------------------------------------------------------------*/
/*---------------------------------------  Password  ---------------------------------------*/
/*------------------------------------------------------------------------------------------*/
            Consumer<ObscureProvider>(
              builder: (context, obscure, child) {
                return GlobalTextField(
                  hint: 'الرقم السرى',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  prefixIcon: Icons.lock_outline,
                  isObscure: obscure.obscure2,
                  borderRadius: 10,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      obscure.switchObscure2();
                    },
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'من فضلك ادخل الرقم السرى';
                    } else if (value.length <= 6) {
                      return 'الرقم السرى يجب ان يكون اكثر من 6 ارقام';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                );
              },
            ),
/*------------------------------------------------------------------------------------------*/
/*---------------------------------------  Sign Btn  ---------------------------------------*/
/*------------------------------------------------------------------------------------------*/
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SignBtn(
                text: 'انشاء حساب',
                onClicked: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    if (authUserState == AuthUserState.doctor) {
                      Provider.of<DoctorProvider>(context, listen: false)
                          .switchDoctor();
                    }
                    context.read<AuthProvider>().signUp(name, username,
                        email.trim(), password, context, authUserState);
                  }
                },
              ),
            ),
            Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
/*-----------------------------------------------------------------------------------*/
/*------------------------------------  Doctor  -------------------------------------*/
/*-----------------------------------------------------------------------------------*/
                InkWell(
                  onTap: () {
                    setState(() {
                      authUserState = AuthUserState.doctor;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      'دكتور',
                      style: GoogleFonts.elMessiri(
                        fontWeight: FontWeight.bold,
                        color: (authUserState == AuthUserState.doctor)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: (authUserState == AuthUserState.doctor)
                          ? Theme.of(context).accentColor
                          : Constants.textFieldColor,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(8)),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 1.5),
                    ),
                  ),
                ),
/*-----------------------------------------------------------------------------------*/
/*------------------------------------  Patient  ------------------------------------*/
/*-----------------------------------------------------------------------------------*/
                InkWell(
                  onTap: () {
                    setState(() {
                      authUserState = AuthUserState.patient;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      'مريض',
                      style: GoogleFonts.elMessiri(
                        fontWeight: FontWeight.bold,
                        color: (authUserState == AuthUserState.patient)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: (authUserState == AuthUserState.patient)
                          ? Theme.of(context).accentColor
                          : Constants.textFieldColor,
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(8)),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
