import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/db/db_patients.dart';
import 'package:medical_app/models/user.dart';

abstract class Auth {
  signUp(name, phoneNum, email, pass, context, AuthUserState authUserState);
  signIn(email, pass, context, AuthUserState authUserState);
  signOut();
}

class AuthProvider implements Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  PatientsDB _patientsDB = PatientsDB();
  DoctorsDB _doctorsDB = DoctorsDB();

/*----------------------------------------------------------------------------------------*/
/*------------------------------------  Get User ID  -------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  getUID() => _auth.currentUser.uid;

/*----------------------------------------------------------------------------------------*/
/*--------------------------------------  Sign Up  ---------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  signUp(
      name, phonrNum, email, pass, context, AuthUserState authUserState) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      if (authUserState == AuthUserState.doctor) {
        await _doctorsDB.saveData(
            Users(id: getUID(), name: name, email: email, phoneNum: phonrNum));
      } else {
        await _patientsDB.saveData(
            Users(id: getUID(), name: name, email: email, phoneNum: phonrNum));
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          showDialoge(context, const Text("هذا الايميل مستخدم من قبل"));
          break;
        case 'operation-not-allowed':
          showDialoge(context, const Text("الخدمة غير فعالة الآن"));
          break;
        case 'invalid-email':
          showDialoge(context, const Text("ايميل غير صحيح"));
          break;
        case 'weak-password':
          showDialoge(context, const Text("الرقم السرى ضعيف"));
          break;
        default:
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
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showDialoge(context, const Text("المستخدم غير موجود"));
          break;
        case 'wrong-password':
          showDialoge(context, const Text("خطأ فى ادخال الرقم السرى"));
          break;
        case 'invalid-email':
          showDialoge(context, const Text("الايميل غير صحيح"));
          break;
        case 'user-disabled':
          showDialoge(context, const Text("تم مسح هذا المستخدم"));
          break;
        default:
          break;
      }
    } catch (e) {
      print(e);
    }
  }

/*----------------------------------------------------------------------------------------*/
/*------------------------------------  Auth State  --------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  Stream<User> get authStateChanges {
    print('Authhhhhhhhhhhhhhhhhh :::: ${_auth.authStateChanges()}');
    return _auth.authStateChanges();
  }

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
      builder: (context) {
        return Dialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: child,
          ),
        );
      },
    );
  }
}
