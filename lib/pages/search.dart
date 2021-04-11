import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/pages/doctor_page.dart';
import 'package:medical_app/pages/doctor_pages/patients_page.dart';

class SearchPage extends SearchDelegate {
  static const String routeName = 'searchPage';
  final String collectionName;

  SearchPage(this.collectionName);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(collectionName).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Text('Loading...');

        final results =
            snapshot.data.docs.where((a) => a['name'].contains(query));

        return ListView(
          children: results
              .map<Widget>(
                (a) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      if (collectionName == Constants.doctorsCollectionName) {
                        Navigator.of(context).pushNamed(DoctorPage.routeName,
                            arguments: a['id']);
                      } else {
                        Navigator.of(context).pushNamed(
                            PatientProfilePage.routeName,
                            arguments: a['id']);
                      }
                    },
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
                                'د / ${a['name']}',
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
                ),
              )
              .toList(),
        );
      },
    );
  }
}
