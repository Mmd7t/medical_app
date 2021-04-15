import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:medical_app/providers/auth_provider.dart';
import 'package:medical_app/providers/obscure_provider.dart';
import 'package:medical_app/providers/user_login_type_provider.dart';
import 'package:medical_app/widgets/global_btn.dart';
import 'package:medical_app/widgets/global_textfield.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String email, password;

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<UserLoginTypeProvider>(context);
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
              child: GlobalBtn(
                text: 'تسجيل الدخول',
                width: MediaQuery.of(context).size.width * 0.9,
                onClicked: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    if (authState.authUserState == AuthUserState.doctor) {
                      Provider.of<DoctorProvider>(context, listen: false)
                          .switchDoctor();
                    }
                    AuthProvider().signIn(email.trim(), password, context,
                        authState.authUserState);
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
                  onTap: () => authState.setAuthState(AuthUserState.doctor),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      'دكتور',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (authState.authUserState == AuthUserState.doctor)
                            ? Colors.white
                            : Colors.black,
                        fontFamily: Constants.fontName,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: (authState.authUserState == AuthUserState.doctor)
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
                  onTap: () => authState.setAuthState(AuthUserState.patient),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      'مريض',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            (authState.authUserState == AuthUserState.patient)
                                ? Colors.white
                                : Colors.black,
                        fontFamily: Constants.fontName,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: (authState.authUserState == AuthUserState.patient)
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
