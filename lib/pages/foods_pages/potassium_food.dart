import 'package:flutter/material.dart';
import 'package:medical_app/widgets/foods_tile.dart';
import 'package:medical_app/widgets/main_template.dart';
import '../../constants.dart';

class PotassiumFood extends StatelessWidget {
  static const String routeName = 'potassiumFood';
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      isHome: false,
      title: 'أغذية غنية بالبوتاسيوم',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headline('خضروات غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.potassiumVegets.length,
                (index) => FoodsTile(
                  img: 'assets/food/potassium/vegets_${index + 1}.jpg',
                  title: Constants.potassiumVegets[index],
                  isPotassiumFood: true,
                ),
              ),
              const SizedBox(height: 10),
              headline('فواكه غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.potassiumFriuts.length,
                (index) => FoodsTile(
                  img: 'assets/food/potassium/fruit_${index + 1}.jpg',
                  title: Constants.potassiumFriuts[index],
                  isPotassiumFood: true,
                ),
              ),
              const SizedBox(height: 10),
              headline('أغذية اخرى غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.otherPotassiumFoods.length,
                (index) => FoodsTile(
                  img: 'assets/food/potassium/other_${index + 1}.jpg',
                  title: Constants.otherPotassiumFoods[index],
                  isPotassiumFood: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  headline(text, context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6.copyWith(
            color: Constants.darkColor,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.fontName,
          ),
    );
  }
}
