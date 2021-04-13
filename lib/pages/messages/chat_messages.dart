import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/widgets/main_template.dart';
import 'package:medical_app/db/db_chats.dart';

import '../../constants.dart';
import 'chat_page.dart';

class ChatMessages extends StatefulWidget {
  static const String routeName = 'chatMessages';
  final String userName;

  const ChatMessages({Key key, this.userName}) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  Stream usersStream, chatRoomsStream;

  getChatRooms() async {
    chatRoomsStream = await ChatsDB().getChatRooms(widget.userName);
    setState(() {});
  }

  onScreenLoaded() async {
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      isHome: false,
      title: 'الرسائل',
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: chatRoomsStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        if (ds["lastMessage"] != null) {
                          return ChatRoomListTile(
                              ds["lastMessage"], ds.id, widget.userName);
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String name = "", username = "", token = '';

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await ChatsDB().getDoctorInfo(username);
    name = "${querySnapshot.docs[0]["name"]}";
    token = "${querySnapshot.docs[0]["token"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          var chatRoomId =
              ChatsDB().getChatRoomIdByUsernames(username, widget.myUsername);
          Map<String, dynamic> chatRoomInfoMap = {
            "users": [username, widget.myUsername],
            'lastMessage': null,
            'lastMessageSendBy': null,
            'lastMessageSendTs': null
          };
          ChatsDB().createChatRoom(chatRoomId, chatRoomInfoMap);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPage(
              myUserName: widget.myUsername,
              otherUserName: username,
              name: name,
              token: token,
            ),
          ));
        },
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: size.width * 0.3,
                height: size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Image.asset(
                  'assets/doctor_1.png',
                  matchTextDirection: true,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name ?? '',
                    style: GoogleFonts.elMessiri(
                        fontSize:
                            Theme.of(context).textTheme.headline6.fontSize - 2,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      '${widget.lastMessage} ',
                      style: GoogleFonts.elMessiri(color: Colors.grey.shade700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
