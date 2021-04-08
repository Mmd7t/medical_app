import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/main_template.dart';
import 'package:medical_app/db/db_chats.dart';

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
    // var size = MediaQuery.of(context).size;
    // var userName = ModalRoute.of(context).settings.arguments;
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
                        return ChatRoomListTile(
                            ds["lastMessage"], ds.id, widget.userName);
                        // return Padding(
                        //   padding: const EdgeInsets.all(5.0),
                        //   child: InkWell(
                        //     onTap: () => Navigator.of(context)
                        //         .pushNamed(ChatPage.routeName),
                        //     child: Card(
                        //       elevation: 2,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(15)),
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             margin: const EdgeInsets.all(10),
                        //             width: size.width * 0.3,
                        //             height: size.width * 0.3,
                        //             decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.circular(13),
                        //             ),
                        //             child: Image.asset(
                        //               'assets/doctor_1.png',
                        //               matchTextDirection: true,
                        //             ),
                        //           ),
                        //           const SizedBox(width: 10),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Text(
                        //                 'د / احمد ماهر',
                        //                 style: GoogleFonts.elMessiri(
                        //                     fontSize: Theme.of(context)
                        //                         .textTheme
                        //                         .headline6
                        //                         .fontSize,
                        //                     color: Constants.darkColor,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               const SizedBox(height: 6),
                        //               Text(
                        //                 'مستشفى الحياه',
                        //                 style: GoogleFonts.elMessiri(
                        //                     color: Colors.grey.shade700),
                        //               ),
                        //               Text(
                        //                 '12 ص : 4 م',
                        //                 style: GoogleFonts.elMessiri(
                        //                     color: Colors.grey.shade700),
                        //               ),
                        //             ],
                        //           ),
                        //           const Spacer(),
                        //           Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Icon(Icons.star, color: Colors.amber[700]),
                        //               const SizedBox(width: 3),
                        //               const Text('4.6'),
                        //             ],
                        //           ),
                        //           const SizedBox(width: 12),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
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
  String name = "", username = "";

  // getThisUserInfo() async {
  //   username =
  //       widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
  //   QuerySnapshot querySnapshot = await ChatsDB().getUserInfo(username);
  //   print(
  //       "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
  //   name = "${querySnapshot.docs[0]["name"]}";
  //   profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";
  //   setState(() {});
  // }

  @override
  void initState() {
    // getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ChatPage(username, name)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(30),
            //   child: Image.network(
            //     profilePicUrl,
            //     height: 40,
            //     width: 40,
            //   ),
            // ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 3),
                Text(widget.lastMessage)
              ],
            )
          ],
        ),
      ),
    );
  }
}
