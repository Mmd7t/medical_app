import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/pages/doctor_page.dart';
import 'package:medical_app/pages/doctor_pages/patients_page.dart';
import 'package:medical_app/widgets/custom_card.dart';

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
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(collectionName).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Text('Loading...');

        final results =
            snapshot.data.docs.where((a) => a['name'].contains(query));

        return ListView(
          children: results
              .map<Widget>(
                (a) => (collectionName == Constants.doctorsCollectionName)
                    ? CustomCard.doctor(
                        name: a['name'],
                        onTap: () {
                          Navigator.of(context).pushNamed(DoctorPage.routeName,
                              arguments: a['id']);
                        },
                        rate: a['rate'],
                      )
                    : CustomCard.patient(
                        name: a['name'],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              PatientProfilePage.routeName,
                              arguments: a['id']);
                        },
                      ),
              )
              .toList(),
        );
      },
    );
  }
}
