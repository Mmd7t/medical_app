import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_app/models/user.dart';

import '../constants.dart';
import 'db.dart';

class PatientsDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<void> deleteData(user) async {
    return await _db
        .collection(Constants.patientsCollectionName)
        .doc(user.id)
        .delete();
  }

  @override
  Stream<Users> getData() {
    return _db
        .collection(Constants.patientsCollectionName)
        .doc(getId())
        .snapshots()
        .map((event) => Users.fromMap(event.data()));
  }

  Future<bool> getPatientEmail(email) async {
    final snapShot = await _db
        .collection(Constants.patientsCollectionName)
        .where("email", isEqualTo: email)
        .get();

    if (snapShot.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Stream<Users> getPatient(id) {
    return _db
        .collection(Constants.patientsCollectionName)
        .doc(id)
        .snapshots()
        .map((event) => Users.fromMap(event.data()));
  }

  Stream<List<Users>> getAllPatients() {
    return _db.collection(Constants.patientsCollectionName).snapshots().map(
        (event) => event.docs.map((e) => Users.fromMap(e.data())).toList());
  }

  @override
  getId() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Future<void> saveData(user) async {
    return await _db
        .collection(Constants.patientsCollectionName)
        .doc(getId())
        .set(user.toMap());
  }

  @override
  Future<void> updateData(user) async {
    return await _db
        .collection(Constants.patientsCollectionName)
        .doc(user.id)
        .update(user.toMap());
  }
}
