import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_app/models/doctor_model.dart';

import '../constants.dart';
import 'db.dart';

class DoctorsDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<void> deleteData(doctor) async {
    return await _db
        .collection(Constants.doctorsCollectionName)
        .doc(doctor.id)
        .delete();
  }

  Future<bool> getDoctorEmail(email) async {
    final snapShot = await _db
        .collection(Constants.doctorsCollectionName)
        .where("email", isEqualTo: email)
        .get();

    if (snapShot.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Stream<DoctorModel> getData() {
    return _db
        .collection(Constants.doctorsCollectionName)
        .doc(getId())
        .snapshots()
        .map((event) => DoctorModel.fromMap(event.data()));
  }

  Stream<DoctorModel> getDoctor(id) {
    return _db
        .collection(Constants.doctorsCollectionName)
        .doc(id)
        .snapshots()
        .map((event) => DoctorModel.fromMap(event.data()));
  }

  Stream<List<DoctorModel>> getAllDoctors() {
    return _db.collection(Constants.doctorsCollectionName).snapshots().map(
        (event) =>
            event.docs.map((e) => DoctorModel.fromMap(e.data())).toList());
  }

  @override
  getId() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Future<void> saveData(doctor) async {
    return await _db
        .collection(Constants.doctorsCollectionName)
        .doc(getId())
        .set(doctor.toMap());
  }

  @override
  Future<void> updateData(doctor) async {
    return await _db
        .collection(Constants.doctorsCollectionName)
        .doc(doctor.id)
        .update(doctor.toMap());
  }

  Stream<QuerySnapshot> getDoctorByName(name) {
    return _db
        .collection(Constants.doctorsCollectionName)
        .where('name', isEqualTo: name)
        .snapshots();
  }
}
