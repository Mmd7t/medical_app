import 'package:medical_app/models/user.dart';

class ChatModel {
  List users;
  String lastMessage;
  String lastMessageSendBy;
  DateTime lastMessageSendTs;
  Chats chats;

  ChatModel({
    this.users,
    this.chats,
    this.lastMessage,
    this.lastMessageSendBy,
    this.lastMessageSendTs,
  });

  factory ChatModel.fromMap(Map<String, dynamic> data) {
    return ChatModel(
      users: data['users'],
      lastMessage: data['lastMessage'],
      lastMessageSendBy: data['lastMessageSendBy'],
      lastMessageSendTs: data['lastMessageSendTs'],
      chats: Chats.fromMap(data["chats"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': users,
      'lastMessage': lastMessage,
      'lastMessageSendBy': lastMessageSendBy,
      'lastMessageSendTs': lastMessageSendTs,
      'chats': chats.toMap(),
    };
  }
}

class Chats {
  String message;
  String sendBy;
  DateTime ts;

  Chats({this.message, this.sendBy, this.ts});
  factory Chats.fromMap(Map<String, dynamic> data) {
    return Chats(
      message: data['message'],
      sendBy: data['sendBy'],
      ts: data['ts'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sendBy': sendBy,
      'ts': ts,
    };
  }
}
