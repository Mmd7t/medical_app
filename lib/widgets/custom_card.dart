import 'package:flutter/material.dart';
import '../constants.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String rate;
  final String workspace;
  final Function onTap;
  final UserType userType;

  const CustomCard.patient({this.name, this.onTap, this.rate, this.workspace})
      : userType = UserType.patient;
  const CustomCard.doctor(
      {this.name, this.onTap, @required this.rate, @required this.workspace})
      : userType = UserType.doctor;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: size.width * 0.3,
                height: size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Image.asset(
                  (userType == UserType.doctor)
                      ? 'assets/doctor_1.png'
                      : 'assets/patient_1.png',
                  matchTextDirection: true,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (userType == UserType.doctor) ? 'د / $name' : '$name',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headline6.fontSize - 3,
                      color: Constants.darkColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constants.fontName,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    (userType == UserType.doctor) ? '$workspace' : 'فشل كلوى',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: Constants.fontName),
                  ),
                  (userType == UserType.doctor)
                      ? Text(
                          '12 ص : 4 م',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontFamily: Constants.fontName,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (userType == UserType.doctor)
                      ? Icon(Icons.star, color: Colors.amber[700])
                      : const SizedBox(),
                  const SizedBox(width: 3),
                  (userType == UserType.doctor) ? Text(rate) : const SizedBox(),
                ],
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
