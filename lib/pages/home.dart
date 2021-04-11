import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/pages/doctor_page.dart';
import 'package:medical_app/pages/search.dart';
import 'package:medical_app/widgets/main_template.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const String routeName = 'patientHome';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                              DoctorPage.routeName,
                              arguments: doctor.id),
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
                                      'د / ${doctor.name}',
                                      style: GoogleFonts.elMessiri(
                                        fontSize: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .fontSize -
                                            3,
                                        color: Constants.darkColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'مستشفى الحياه',
                                      style: GoogleFonts.elMessiri(
                                          color: Colors.grey.shade700),
                                    ),
                                    Text(
                                      '12 ص : 4 م',
                                      style: GoogleFonts.elMessiri(
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, color: Colors.amber[700]),
                                    const SizedBox(width: 3),
                                    const Text('4.6'),
                                  ],
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
