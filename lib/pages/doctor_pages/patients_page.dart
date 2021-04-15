import 'package:flutter/material.dart';
import 'package:medical_app/db/db_chats.dart';
import 'package:medical_app/db/db_patients.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/models/user.dart';
import 'package:medical_app/pages/messages/chat_page.dart';
import 'package:medical_app/widgets/profile_template.dart';
import 'package:provider/provider.dart';

class PatientProfilePage extends StatelessWidget {
  static const String routeName = 'patientProfilePage';
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments;
    var doctor = Provider.of<DoctorModel>(context);
    return StreamBuilder<Users>(
      stream: PatientsDB().getPatient(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          Users patient = snapshot.data;
          return ProfileTemplate.patient(
            name: patient.name,
            rate: (doctor.rate == null) ? '0' : '${doctor.rate}',
            onTap: () {
              var chatRoomId = ChatsDB()
                  .getChatRoomIdByUsernames(patient.username, doctor.username);
              Map<String, dynamic> chatRoomInfoMap = {
                "users": [patient.username, doctor.username],
                'lastMessage': null,
                'lastMessageSendBy': null,
                'lastMessageSendTs': null
              };
              ChatsDB().createChatRoom(chatRoomId, chatRoomInfoMap);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPage(
                  myUserName: doctor.username,
                  otherUserName: patient.username,
                  name: patient.name,
                  token: patient.token,
                  myname: 'د / ${doctor.name}',
                ),
              ));
            },
          );
        }
      },
    );
  }
}
