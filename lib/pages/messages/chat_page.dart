import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/db/db_chats.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:medical_app/widgets/clippers.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = 'chatPage';
  final String myUserName;
  final String otherUserName;
  final String name;
  final String token;
  final String myname;

  const ChatPage({
    Key key,
    this.myUserName,
    this.otherUserName,
    this.name,
    this.token,
    this.myname,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String chatRoomId, messageId = "";
  Stream messageStream;
  TextEditingController messageTextEdittingController = TextEditingController();
  ScrollController controller = ScrollController();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  getInfo() {
    chatRoomId = ChatsDB()
        .getChatRoomIdByUsernames(widget.myUserName, widget.otherUserName);
  }

/*-------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Add Message Func.  -----------------------------------------*/
/*-------------------------------------------------------------------------------------------------------*/

  addMessage(bool sendClicked) {
    if (messageTextEdittingController.text != "") {
      String message = messageTextEdittingController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": widget.myUserName,
        "ts": lastMessageTs,
      };

      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      ChatsDB().addMessage(chatRoomId, messageId, messageInfoMap).then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": widget.myUserName
        };

        ChatsDB().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sendClicked) {
          // remove the text in the message input field
          messageTextEdittingController.text = "";
          // make message id blank to get regenerated on next message send
          messageId = "";
        }
        Constants().sendFcmMessage(widget.myname, message, widget.token);
      });
    }
  }

/*-------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Chat Message Tile  -----------------------------------------*/
/*-------------------------------------------------------------------------------------------------------*/

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4).copyWith(
                left: (sendByMe) ? 60 : 16, right: (sendByMe) ? 16 : 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomRight:
                    sendByMe ? Radius.circular(0) : Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: sendByMe ? Radius.circular(24) : Radius.circular(0),
              ),
              color: sendByMe ? Colors.blue : const Color(0xFFE7E7E7),
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              message,
              style: TextStyle(color: (sendByMe) ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }

/*-------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Chat Messages List  ----------------------------------------*/
/*-------------------------------------------------------------------------------------------------------*/

  chatsMessagess() {
    return Expanded(
      child: ClipPath(
        clipper: ChatClipper(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).accentColor,
              Constants.color2,
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 8, top: 3),
          child: ClipPath(
            clipper: ChatClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: StreamBuilder(
                  stream: messageStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        controller: controller,
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.docs[index];
                          return chatMessageTile(
                            ds["message"],
                            widget.myUserName == ds["sendBy"],
                          );
                        },
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  getAndSetMessages() async {
    messageStream = await ChatsDB().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getInfo();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
    controller.jumpTo(controller.position.maxScrollExtent);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatPage(
            myUserName: widget.myUserName,
            otherUserName: widget.otherUserName,
            name: widget.name,
            token: widget.token,
            myname: widget.myname,
          ),
        ),
      );
    });
  }

/*-------------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Chat Decoration Page  ---------------------------------------*/
/*-------------------------------------------------------------------------------------------------------*/

  @override
  Widget build(BuildContext context) {
    var isDoctor = Provider.of<DoctorProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Constants.textFieldColor),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 25,
                          child: Hero(
                            tag: 'doctor img',
                            child: Image.asset(
                                (isDoctor.doctor)
                                    ? 'assets/patient_1.png'
                                    : 'assets/doctor_1.png',
                                matchTextDirection: true),
                          ),
                        ),
                        title: Hero(
                          tag: 'doctor name',
                          child: Text(
                            (isDoctor.doctor)
                                ? '${widget.name}'
                                : 'د / ${widget.name}',
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Constants.darkColor,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: Constants.fontName,
                                    ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios_outlined),
                          color: Theme.of(context).accentColor,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: Column(
                        children: [
/*-------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Chat Messages  ----------------------------------------*/
/*-------------------------------------------------------------------------------------------------*/
                          chatsMessagess(),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            height: kBottomNavigationBarHeight + 5,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: messageTextEdittingController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "اكتب رسالتك",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                FloatingActionButton(
                                  heroTag: 'chat',
                                  onPressed: () {
                                    addMessage(true);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor:
                                      Theme.of(context).accentColor,
                                  child: const Icon(Icons.send_outlined),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
