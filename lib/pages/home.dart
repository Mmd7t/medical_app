import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/pages/doctor_page.dart';
import 'package:medical_app/pages/search.dart';
import 'package:medical_app/widgets/custom_card.dart';
import 'package:medical_app/widgets/main_template.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const String routeName = 'patientHome';
  @override
  Widget build(BuildContext context) {
    var listOfDoctors = Provider.of<List<DoctorModel>>(context);
    return MainTemplate(
      isHome: true,
      title: 'أطباء الفشل الكلوى',
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
                      delegate: SearchPage(Constants.doctorsCollectionName));
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
            (listOfDoctors == null)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listOfDoctors.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = listOfDoctors[index];
                      return CustomCard.doctor(
                        name: doctor.name,
                        workspace: doctor.workSpace,
                        onTap: () {
                          Navigator.of(context).pushNamed(DoctorPage.routeName,
                              arguments: doctor.id);
                        },
                        rate: (doctor.rate == null) ? '0' : '${doctor.rate}',
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
