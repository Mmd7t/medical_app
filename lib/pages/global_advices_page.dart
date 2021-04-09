import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/widgets/main_template.dart';

import '../constants.dart';

class ForbiddenFood extends StatelessWidget {
  static const String routeName = 'forbiddenFood';
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      isHome: false,
      title: 'نصائح عامة',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  Constants.forbeddinFood.length,
                  (index) => Text(
                    Constants.forbeddinFood[index],
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
