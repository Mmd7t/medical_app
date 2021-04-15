import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/db/db_patients.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/models/user.dart';
import 'package:provider/provider.dart';

import 'doctor_provider.dart';

abstract class Auth {
  signUp(name, phoneNum, email, pass, context, AuthUserState authUserState,
      {phoneNumer, workSpace});
  signIn(email, pass, context, AuthUserState authUserState);
  signOut();
}

class AuthProvider implements Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  PatientsDB _patientsDB = PatientsDB();
  DoctorsDB _doctorsDB = DoctorsDB();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String token;

/*----------------------------------------------------------------------------------------*/
/*------------------------------------  Get User ID  -------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  getUID() => _auth.currentUser.uid;

/*----------------------------------------------------------------------------------------*/
/*--------------------------------------  Sign Up  ---------------------------------------*/
/*----------------------------------------------------------------------------------------*/

  getToken() async {
    return await _messaging.getToken();
  }

  @override
  signUp(name, username, email, pass, context, AuthUserState authUserState,
      {phoneNumer, workSpace}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      token = await _messaging.getToken();
      if (authUserState == AuthUserState.doctor) {
        await _doctorsDB.saveData(DoctorModel(
            id: getUID(),
            name: name,
            email: email,
            username: username,
            phoneNumber: phoneNumer,
            workSpace: workSpace,
            token: token));
      } else {
        await _patientsDB.saveData(Users(
            id: getUID(),
            name: name,
            email: email,
            username: username,
            token: token));
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          showDialoge(context, "هذا الايميل مستخدم من قبل");
          break;
        case 'operation-not-allowed':
          showDialoge(context, "الخدمة غير فعالة الآن");
          break;
        case 'invalid-email':
          showDialoge(context, "ايميل غير صحيح");
          break;
        case 'weak-password':
          showDialoge(context, "الرقم السرى ضعيف");
          break;
        default:
          showDialoge(context, "حدث خطأ\nمن فضلك حاول التسجيل مرة اخرى");
          break;
      }
    } catch (e) {
      print(e);
    }
  }

/*----------------------------------------------------------------------------------------*/
/*--------------------------------------  Sign in  ---------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  signIn(email, pass, context, AuthUserState authUserState) async {
    try {
      if (authUserState == AuthUserState.doctor) {
        await DoctorsDB().getDoctorEmail(email).then((value) {
          if (value) {
            Provider.of<DoctorProvider>(context, listen: false).switchDoctor();
            _auth.signInWithEmailAndPassword(email: email, password: pass);
          } else {
            showDialoge(
                context, "انت لست بطبيب\nمن فضلك التزم بسياسات التطبيق");
          }
        });
      } else {
        _auth.signInWithEmailAndPassword(email: email, password: pass);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showDialoge(context, "المستخدم غير موجود");
          break;
        case 'wrong-password':
          showDialoge(context, "خطأ فى ادخال الرقم السرى");
          break;
        case 'invalid-email':
          showDialoge(context, "الايميل غير صحيح");
          break;
        case 'user-disabled':
          showDialoge(context, "تم مسح هذا المستخدم");
          break;
        default:
          showDialoge(context, "حدث خطأ\nمن فضلك حاول التسجيل مرة اخرى");
          break;
      }
    } catch (e) {
      print(e);
    }
  }

/*----------------------------------------------------------------------------------------*/
/*------------------------------------  Auth State  --------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  Stream<User> get authStateChanges => _auth.authStateChanges();

/*----------------------------------------------------------------------------------------*/
/*--------------------------------------  Sign out  --------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  signOut() async {
    await _auth.signOut();
  }

  showDialoge(context, child) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('حدث خطأ'),
          content: Text(child, textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('حسنا'),
            ),
          ],
        );
      },
    );
  }
}
