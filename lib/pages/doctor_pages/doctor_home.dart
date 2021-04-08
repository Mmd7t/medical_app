import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/db/db_chats.dart';
import 'package:medical_app/db/db_patients.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/models/user.dart';
import 'package:medical_app/pages/main_template.dart';
import 'package:medical_app/pages/messages/chat_page.dart';
import 'package:provider/provider.dart';

class DoctorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var doctor = Provider.of<DoctorModel>(context);
    return MainTemplate(
      isHome: true,
      userType: UserType.doctor,
      title: 'مرضى الفشل الكلوى',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 45).copyWith(top: 20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'بحث',
                  filled: true,
                  fillColor: Constants.textFieldColor,
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon:
                      Icon(Icons.search, color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            StreamBuilder<List<Users>>(
                stream: PatientsDB().getAllPatients(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    List<Users> listOfPatients = snapshot.data;
                    print(listOfPatients.length);
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listOfPatients.length,
                      itemBuilder: (context, index) {
                        Users user = listOfPatients[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
                              var chatRoomId = ChatsDB()
                                  .getChatRoomIdByUsernames(
                                      user.username, doctor.username);
                              Map<String, dynamic> chatRoomInfoMap = {
                                "users": [user.username, doctor.username]
                              };
                              ChatsDB()
                                  .createChatRoom(chatRoomId, chatRoomInfoMap);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  id: user.id,
                                  myUserName: doctor.username,
                                  otherUserName: user.username,
                                  name: user.name,
                                ),
                              ));
                            },
                            // Navigator.of(context).pushNamed(DoctorPage.routeName),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
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
                                      'assets/patient_1.png',
                                      matchTextDirection: true,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${user.name}',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .fontSize,
                                            color: Constants.darkColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'فشل كلوى',
                                        style: GoogleFonts.elMessiri(
                                            color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
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
