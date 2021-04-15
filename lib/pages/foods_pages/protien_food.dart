import 'package:flutter/material.dart';
import 'package:medical_app/widgets/main_template.dart';
import '../../constants.dart';

class ProtienFood extends StatelessWidget {
  static const String routeName = 'protienFood';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MainTemplate(
      isHome: false,
      title: 'نسبة البروتين فى كل 100 جرام',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/food/food_${index + 1}.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Constants.foods[index],
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .fontSize -
                                    2,
                                color: Constants.darkColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: Constants.fontName,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(Constants.gramsInFood[index]),
                          ],
                        ),
                      ],
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
