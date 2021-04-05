import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_app/models/user.dart';

import '../constants.dart';
import 'db.dart';

class DoctorsDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<void> deleteData(user) async {
    return await _db
        .collection(Constants.doctorsCollectionName)
        .doc(user.id)
        .delete();
  }

  @override
  Stream<Users> getData() {
    return _db
        .collection(Constants.doctorsCollectionName)
        .doc(getId())
        .snapshots()
        .map((event) => Users.fromMap(event.data()));
  }

  @override
  getId() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Future<void> saveData(user) async {
    return await _db
        .collection(Constants.doctorsCollectionName)
        .doc(getId())
        .set(user.toMap());
  }

  @override
  Future<void> updateData(user) async {
    return await _db
        .collection(Constants.doctorsCollectionName)
        .doc(user.id)
        .update(user.toMap());
  }
}
