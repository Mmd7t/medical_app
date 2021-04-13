import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:medical_app/providers/auth_provider.dart';
import 'package:medical_app/providers/obscure_provider.dart';
import 'package:medical_app/widgets/global_textfield.dart';
import 'package:provider/provider.dart';
import 'sign_btn.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String email, password;
  AuthUserState authUserState = AuthUserState.patient;
  String code = 'amal1234';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
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
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Consumer<ObscureProvider>(
              builder: (context, obscure, child) {
                return GlobalTextField(
                  hint: 'الرقم السرى',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  prefixIcon: Icons.lock_outline,
                  isObscure: obscure.obscure1,
                  borderRadius: 10,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      obscure.switchObscure1();
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SignBtn(
                text: 'تسجيل الدخول',
                onClicked: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    if (authUserState == AuthUserState.doctor) {
                      Provider.of<DoctorProvider>(context, listen: false)
                          .switchDoctor();
                      showConfirmationDialog(context);
                    } else {
                      AuthProvider().signIn(
                          email.trim(), password, context, authUserState);
                    }
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

  showConfirmationDialog(context) {
    final form = GlobalKey<FormState>();
    String val;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('تأكيد الهوية'),
        content: Form(
          key: form,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'ادخل الكود',
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
                return 'من فضلك ادخل الكود';
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              setState(() {
                val = newValue;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (form.currentState.validate()) {
                form.currentState.save();
                if (code == val) {
                  Navigator.of(context).pop();
                  AuthProvider()
                      .signIn(email.trim(), password, context, authUserState);
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('الكود غير صحيح'),
                    ),
                  );
                }
              }
            },
            child: const Text('ادخال'),
          ),
        ],
      ),
    );
  }
}
