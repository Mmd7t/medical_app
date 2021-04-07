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
    return FirebaseFirestore.instance
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
        .orderBy("ts", descending: true)
        .snapshots();
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  // Future<Stream<QuerySnapshot>> getChatRooms() async {
  //   String myUsername = await SharedPreferenceHelper().getUserName();
  //   return FirebaseFirestore.instance
  //       .collection("chatrooms")
  //       .orderBy("lastMessageSendTs", descending: true)
  //       .where("users", arrayContains: myUsername)
  //       .snapshots();
  // }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }
}
