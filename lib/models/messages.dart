class Messages {
  String message;
  String sendBy;
  DateTime timeStamp;

  Messages({
    this.message,
    this.sendBy,
    this.timeStamp,
  });

  factory Messages.fromMap(Map<String, dynamic> data) {
    return Messages(
      message: data['message'],
      sendBy: data['sendBy'],
      timeStamp: data['timeStamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sendBy': sendBy,
      'timeStamp': timeStamp,
    };
  }
}

class LastMessage {
  String lastMessage;
  DateTime timeStamp;
  String sendBy;

  LastMessage({
    this.lastMessage,
    this.sendBy,
    this.timeStamp,
  });

  factory LastMessage.fromMap(Map<String, dynamic> data) {
    return LastMessage(
      lastMessage: data['lastMessage'],
      sendBy: data['sendBy'],
      timeStamp: data['timeStamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lastMessage': lastMessage,
      'sendBy': sendBy,
      'timeStamp': timeStamp,
    };
  }
}
