import 'package:flutter/material.dart';
import 'package:medical_app/widgets/foods_tile.dart';
import 'package:medical_app/widgets/main_template.dart';
import '../../constants.dart';

class ProtienFood extends StatelessWidget {
  static const String routeName = 'protienFood';
  @override
  Widget build(BuildContext context) {
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
                return FoodsTile(
                  img: 'assets/food/food_${index + 1}.jpeg',
                  title: Constants.foods[index],
                  subTitle: Constants.gramsInFood[index],
                  isPotassiumFood: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
