import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/chat_messages.dart';
import 'package:medical_app/widgets/clippers.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = 'chatPage';
  @override
  Widget build(BuildContext context) {
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
                          maxRadius: 40,
                          child: Hero(
                            tag: 'doctor img',
                            child: Image.asset('assets/doctor_1.png',
                                matchTextDirection: true),
                          ),
                        ),
                        title: Hero(
                          tag: 'doctor name',
                          child: Text(
                            'د / محمد ماهر',
                            style: GoogleFonts.elMessiri(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .fontSize,
                              color: Constants.darkColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          'متصل',
                          style: GoogleFonts.elMessiri(
                            fontSize:
                                Theme.of(context).textTheme.bodyText1.fontSize,
                            color: Colors.amber[700],
                            fontWeight: FontWeight.w600,
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
                    flex: 7,
                    child: Container(
                      child: Column(
                        children: [
/*-------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Chat Messages  ----------------------------------------*/
/*-------------------------------------------------------------------------------------------------*/
                          Expanded(
                            child: ClipPath(
                              clipper: ChatClipper(),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).accentColor,
                                        Constants.color2,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.only(bottom: 8, top: 3),
                                child: ClipPath(
                                  clipper: ChatClipper(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30)),
                                    ),
                                    child: ListView.builder(
                                      itemCount: messages.length,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 20),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Align(
                                            alignment:
                                                (messages[index].messageType ==
                                                        "receiver"
                                                    ? Alignment.topLeft
                                                    : Alignment.topRight),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: (messages[index]
                                                            .messageType ==
                                                        "receiver"
                                                    ? Colors.grey.shade500
                                                        .withOpacity(0.3)
                                                    : Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              padding: const EdgeInsets.all(13),
                                              child: Text(
                                                messages[index].messageContent,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5)
                                .copyWith(left: 10, right: 10),
                            height: kBottomNavigationBarHeight + 10,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
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
                                  onPressed: () {},
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
