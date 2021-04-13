import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/db/db_chats.dart';
import 'package:medical_app/db/db_patients.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/models/user.dart';
import 'package:medical_app/pages/messages/chat_page.dart';
import 'package:provider/provider.dart';

class PatientProfilePage extends StatelessWidget {
  static const String routeName = 'patientProfilePage';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var id = ModalRoute.of(context).settings.arguments;
    var doctor = Provider.of<DoctorModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(width: double.infinity, height: double.infinity),
          Container(
            width: size.width,
            height: size.height / 2,
            color: Constants.textFieldColor,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 15),
            child: Image.asset(
              'assets/patient_1.png',
              matchTextDirection: true,
              width: size.width * 0.7,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  color: Theme.of(context).accentColor,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              width: size.width,
              height: size.height * 0.7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Constants.color2,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
              ),
              child: Container(
                width: size.width,
                height: size.height * 0.7,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                ),
                child: ListView(
                  children: [
                    StreamBuilder<Users>(
                        stream: PatientsDB().getPatient(id),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            Users patient = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: 'doctor name',
                                      child: Text(
                                        '${patient.name}',
                                        style: GoogleFonts.elMessiri(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .fontSize,
                                          color: Constants.darkColor,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'فشل كلوى',
                                      style: GoogleFonts.elMessiri(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .fontSize,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: 'call',
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      backgroundColor: Colors.green,
                                      child: const Icon(Icons.call_outlined),
                                    ),
                                    const SizedBox(width: 10),
                                    FloatingActionButton(
                                      heroTag: 'chat',
                                      onPressed: () {
                                        var chatRoomId = ChatsDB()
                                            .getChatRoomIdByUsernames(
                                                patient.username,
                                                doctor.username);
                                        Map<String, dynamic> chatRoomInfoMap = {
                                          "users": [
                                            patient.username,
                                            doctor.username
                                          ],
                                          'lastMessage': null,
                                          'lastMessageSendBy': null,
                                          'lastMessageSendTs': null
                                        };
                                        ChatsDB().createChatRoom(
                                            chatRoomId, chatRoomInfoMap);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                            id: id,
                                            myUserName: doctor.username,
                                            otherUserName: patient.username,
                                            name: patient.name,
                                          ),
                                        ));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      child:
                                          const Icon(Icons.messenger_rounded),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        }),
                    const SizedBox(height: 30),
                    Text(
                      'نبذة عن الحالة',
                      style: GoogleFonts.elMessiri(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize + 2,
                        color: Constants.darkColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'المريض يعانى من الم فى المعدة و احيانا يشغر بالغثيان و القيئ',
                      style: GoogleFonts.elMessiri(
                        height: 2,
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize,
                        color: Constants.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
