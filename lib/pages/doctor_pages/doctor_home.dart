import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/user.dart';
import 'package:medical_app/pages/doctor_pages/patients_page.dart';
import 'package:medical_app/widgets/custom_card.dart';
import 'package:medical_app/widgets/main_template.dart';
import 'package:provider/provider.dart';

import '../search.dart';

class DoctorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listOfPatients = Provider.of<List<Users>>(context);
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
                onTap: () {
                  FocusScope.of(context).unfocus();
                  TextEditingController().clear();
                  showSearch(
                      context: context,
                      delegate: SearchPage(Constants.patientsCollectionName));
                },
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
            (listOfPatients == null)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listOfPatients.length,
                    itemBuilder: (context, index) {
                      Users user = listOfPatients[index];
                      return CustomCard.patient(
                        name: user.name,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              PatientProfilePage.routeName,
                              arguments: user.id);
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
