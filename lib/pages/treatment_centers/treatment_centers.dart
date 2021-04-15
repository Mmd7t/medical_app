import 'package:flutter/material.dart';
import 'package:medical_app/widgets/main_template.dart';
import '../../constants.dart';
import 'treatment_details_page.dart';

class TreatmentCenter extends StatelessWidget {
  static const String routeName = 'treatmentCenter';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MainTemplate(
      isHome: false,
      title: 'مراكز الفشل الكلوى',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Constants.treatmentCenters.length,
              itemBuilder: (context, index) {
                var val = Constants.treatmentCenters[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        TreatmentDetailsPage.routeName,
                        arguments: index),
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
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/treatment.png',
                              matchTextDirection: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: Text(
                                val['name'],
                                softWrap: true,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: Constants.darkColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Constants.fontName,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
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
