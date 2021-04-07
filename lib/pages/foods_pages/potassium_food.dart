import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/pages/main_template.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headline('خضروات غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.potassiumVegets.length,
                (index) => Text(
                  Constants.potassiumVegets[index],
                  style: GoogleFonts.elMessiri(
                      height: 1.7,
                      fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                      color: Constants.darkColor),
                ),
              ),
              const SizedBox(height: 10),
              headline('فواكه غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.potassiumFriuts.length,
                (index) => Text(
                  Constants.potassiumFriuts[index],
                  style: GoogleFonts.elMessiri(
                      height: 1.7,
                      fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                      color: Constants.darkColor),
                ),
              ),
              const SizedBox(height: 10),
              headline('أغذية اخرى غنية بالبوتاسيوم', context),
              ...List.generate(
                Constants.otherPotassiumFoods.length,
                (index) => Text(
                  Constants.otherPotassiumFoods[index],
                  style: GoogleFonts.elMessiri(
                      height: 1.7,
                      fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                      color: Constants.darkColor),
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
      style: GoogleFonts.elMessiri(
          fontSize: Theme.of(context).textTheme.headline6.fontSize,
          color: Constants.darkColor,
          fontWeight: FontWeight.bold),
    );
  }
}
