class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({
    this.messageContent,
    this.messageType,
  });
}

final List<ChatMessage> messages = [
  ChatMessage(messageContent: "اهلا دكتور", messageType: "sender"),
  ChatMessage(messageContent: "كيف حالك ؟؟", messageType: "sender"),
  ChatMessage(messageContent: "بخير الحمدلله", messageType: "receiver"),
  ChatMessage(
      messageContent: "انا اشتكى من الم بالمعدة", messageType: "sender"),
  ChatMessage(messageContent: "عليك بكثرة شرب الماء", messageType: "receiver"),
  ChatMessage(messageContent: "حسنا سأفعل", messageType: "sender"),
  ChatMessage(messageContent: "خير باذن الله", messageType: "receiver"),
  ChatMessage(messageContent: "شكرا جداا لك", messageType: "sender"),
];
