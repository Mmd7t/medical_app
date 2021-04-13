import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class ChatsDB {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection(Constants.chatsCollectionName)
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return _db
        .collection(Constants.chatsCollectionName)
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await _db
        .collection(Constants.chatsCollectionName)
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return _db
          .collection(Constants.chatsCollectionName)
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return _db
        .collection(Constants.chatsCollectionName)
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: false)
        .snapshots();
  }

  int start = 0;
  int end = 1;
  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(start, end).codeUnitAt(0) >
        b.substring(start, end).codeUnitAt(0)) {
      return "$b\_$a";
    } else if (a.substring(start, end).codeUnitAt(0) ==
        b.substring(start, end).codeUnitAt(0)) {
      start++;
      end++;
      return getChatRoomIdByUsernames(a, b);
    } else {
      return "$a\_$b";
    }
  }

  Future<Stream<QuerySnapshot>> getChatRooms(userName) async {
    return _db
        .collection(Constants.chatsCollectionName)
        .where("users", arrayContains: userName)
        .snapshots();
  }

  Future<QuerySnapshot> getDoctorInfo(String username) async {
    return await _db
        .collection(Constants.doctorsCollectionName)
        .where("username", isEqualTo: username)
        .get();
  }

  Future<QuerySnapshot> getPatientInfo(String username) async {
    return await _db
        .collection(Constants.patientsCollectionName)
        .where("username", isEqualTo: username)
        .get();
  }
}
