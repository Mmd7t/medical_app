import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/providers/rate_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class DoctorRate extends StatefulWidget {
  @override
  _DoctorRateState createState() => _DoctorRateState();
}

class _DoctorRateState extends State<DoctorRate> {
  @override
  Widget build(BuildContext context) {
    var rate = Provider.of<RateProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
/*---------------------------------------------------------------------------------------------*/
/*---------------------------------------  Plus Button  ---------------------------------------*/
/*---------------------------------------------------------------------------------------------*/
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Constants.color2,
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: MaterialButton(
                child: const Icon(Icons.add, color: Colors.white, size: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (rate.rate < 5) {
                    rate.setRate(rate.rate + 1);
                  }
                },
              ),
            ),
          ),
/*---------------------------------------------------------------------------------------------*/
/*----------------------------------------  Rate Text  ----------------------------------------*/
/*---------------------------------------------------------------------------------------------*/
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Constants.color2,
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  rate.rate.toStringAsFixed(0),
                  style: GoogleFonts.elMessiri(
                    fontWeight: FontWeight.w900,
                    color: Constants.darkColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
/*---------------------------------------------------------------------------------------------*/
/*---------------------------------------  Minus Button  --------------------------------------*/
/*---------------------------------------------------------------------------------------------*/
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Constants.color2,
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: MaterialButton(
                child: const Icon(Icons.remove, color: Colors.white, size: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (rate.rate > 0) {
                    rate.setRate(rate.rate - 1);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
