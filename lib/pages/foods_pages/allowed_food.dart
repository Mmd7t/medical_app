import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/pages/main_template.dart';
import '../../constants.dart';

class AllowedFood extends StatelessWidget {
  static const String routeName = 'allowedFood';
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      isHome: false,
      title: 'الأغذية المسموحة',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headline('أغذية مسموح بها أكثر من مرة فى اليوم', context),
                ...List.generate(
                  Constants.allowedFoodsmanyTimes.length,
                  (index) => Text(
                    Constants.allowedFoodsmanyTimes[index],
                    style: GoogleFonts.elMessiri(
                        height: 1.7,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1.fontSize,
                        color: Constants.darkColor),
                  ),
                ),
                const SizedBox(height: 10),
                headline('غذاء مسموح من مره الى مرتين في اليوم', context),
                ...List.generate(
                  Constants.allowedFoods1or2TimesAday.length,
                  (index) => Text(
                    Constants.allowedFoods1or2TimesAday[index],
                    style: GoogleFonts.elMessiri(
                        height: 1.7,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1.fontSize,
                        color: Constants.darkColor),
                  ),
                ),
                const SizedBox(height: 10),
                headline('غذاء مسموح من ثلاث الى أربع مرت في اليوم', context),
                ...List.generate(
                  Constants.allowedFoods3or4TimesAday.length,
                  (index) => Text(
                    Constants.allowedFoods3or4TimesAday[index],
                    style: GoogleFonts.elMessiri(
                        height: 1.7,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1.fontSize,
                        color: Constants.darkColor),
                  ),
                ),
                const SizedBox(height: 10),
                headline('غذاء مسموح من مرتين الى ثلاث مرات في الشهر', context),
                ...List.generate(
                  Constants.allowedFoods2or3TimesAmonth.length,
                  (index) => Text(
                    Constants.allowedFoods2or3TimesAmonth[index],
                    style: GoogleFonts.elMessiri(
                        height: 1.7,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1.fontSize,
                        color: Constants.darkColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headline(text, context) {
    return Text(
      text,
      style: GoogleFonts.elMessiri(
          fontSize: Theme.of(context).textTheme.headline6.fontSize - 2,
          color: Constants.darkColor,
          fontWeight: FontWeight.bold),
    );
  }
}
