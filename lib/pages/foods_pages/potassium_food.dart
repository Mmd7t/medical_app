import 'package:flutter/material.dart';
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
                (index) => Text(
                  Constants.potassiumVegets[index],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        height: 1.7,
                        color: Constants.darkColor,
                        fontFamily: Constants.fontName,
                      ),
                ),
              ),
              const SizedBox(height: 10),
              headline('فواكه غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.potassiumFriuts.length,
                (index) => Text(
                  Constants.potassiumFriuts[index],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        height: 1.7,
                        color: Constants.darkColor,
                        fontFamily: Constants.fontName,
                      ),
                ),
              ),
              const SizedBox(height: 10),
              headline('أغذية اخرى غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.otherPotassiumFoods.length,
                (index) => Text(
                  Constants.otherPotassiumFoods[index],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        height: 1.7,
                        color: Constants.darkColor,
                        fontFamily: Constants.fontName,
                      ),
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
