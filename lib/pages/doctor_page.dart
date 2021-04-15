import 'package:flutter/material.dart';
import 'package:medical_app/db/db_chats.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/models/user.dart';
import 'package:medical_app/widgets/doctor_rate.dart';
import 'package:medical_app/widgets/profile_template.dart';
import 'package:provider/provider.dart';
import 'messages/chat_page.dart';

class DoctorPage extends StatelessWidget {
  static const String routeName = 'doctorPage';

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments;
    var patient = Provider.of<Users>(context);
    return StreamBuilder<DoctorModel>(
      stream: DoctorsDB().getDoctor(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          DoctorModel doctor = snapshot.data;
          return ProfileTemplate.doctor(
            name: doctor.name,
            phoneNum: doctor.phoneNumber,
            workSpace: doctor.workSpace,
            rate: (doctor.rate == null) ? '0' : '${doctor.rate}',
            numOfRates: doctor.numOfRates.toString(),
            onTap: () {
              var chatRoomId = ChatsDB()
                  .getChatRoomIdByUsernames(doctor.username, patient.username);
              Map<String, dynamic> chatRoomInfoMap = {
                "users": [doctor.username, patient.username],
                'lastMessage': null,
                'lastMessageSendBy': null,
                'lastMessageSendTs': null
              };
              ChatsDB().createChatRoom(chatRoomId, chatRoomInfoMap);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPage(
                  myUserName: patient.username,
                  otherUserName: doctor.username,
                  name: doctor.name,
                  token: doctor.token,
                  myname: patient.name,
                ),
              ));
            },
            fab: DoctorRate(
              doctorModel: DoctorModel(
                name: doctor.name,
                email: doctor.email,
                phoneNumber: doctor.phoneNumber,
                username: doctor.username,
                workSpace: doctor.workSpace,
                rate: doctor.rate,
                numOfRates: doctor.numOfRates,
                id: id,
              ),
            ),
          );
        }
      },
    );
  }
}
