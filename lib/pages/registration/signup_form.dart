import 'package:flutter/material.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:medical_app/providers/auth_provider.dart';
import 'package:medical_app/providers/obscure_provider.dart';
import 'package:medical_app/providers/user_login_type_provider.dart';
import 'package:medical_app/widgets/global_btn.dart';
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
  String code = 'amal1234';

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<UserLoginTypeProvider>(context);
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
              child: GlobalBtn(
                text: 'انشاء حساب',
                width: MediaQuery.of(context).size.width * 0.9,
                onClicked: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    if (authState.authUserState == AuthUserState.doctor) {
                      Provider.of<DoctorProvider>(context, listen: false)
                          .switchDoctor();
                      showDoctorDialog(context, authState);
                    } else {
                      context.read<AuthProvider>().signUp(
                          name,
                          username,
                          email.trim(),
                          password,
                          context,
                          authState.authUserState);
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
                        fontFamily: Constants.fontName,
                        color:
                            (authState.authUserState == AuthUserState.patient)
                                ? Colors.white
                                : Colors.black,
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

/*-----------------------------------------------------------------------------------*/
/*------------------------------  Doctor Data Dialog  -------------------------------*/
/*-----------------------------------------------------------------------------------*/

  showDoctorDialog(context, authState) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController workController = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'استكمال البيانات',
          style: const TextStyle(
              color: Constants.darkColor, fontFamily: Constants.fontName),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phoneController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'ادخل رقم الهاتف',
                filled: true,
                fillColor: Constants.textFieldColor,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: workController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'ادخل عنوان مقر العمل',
                filled: true,
                fillColor: Constants.textFieldColor,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showConfirmationDialog(context, authState, phoneController.text,
                  workController.text);
            },
            child: const Text('ادخال'),
          ),
        ],
      ),
    );
  }

/*-----------------------------------------------------------------------------------*/
/*--------------------------  Doctor Confirmation Dialog  ---------------------------*/
/*-----------------------------------------------------------------------------------*/

  showConfirmationDialog(context, authState, phoneNum, workspace) {
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
                  context.read<AuthProvider>().signUp(
                        name,
                        username,
                        email.trim(),
                        password,
                        context,
                        authState.authUserState,
                        phoneNumer: phoneNum,
                        workSpace: workspace,
                      );
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
