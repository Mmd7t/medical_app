import 'package:flutter/material.dart';

import '../constants.dart';

enum BtnEnum { withoutIcon, withIcon }

class GlobalBtn extends StatelessWidget {
  final String text;
  final Function onClicked;
  final double width;
  final BtnEnum btnEnum;
  final Icon icon;

  const GlobalBtn({this.text, this.onClicked, this.width, this.icon})
      : btnEnum = BtnEnum.withoutIcon;
  const GlobalBtn.icon({this.text, this.onClicked, this.width, this.icon})
      : btnEnum = BtnEnum.withIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Constants.color2,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: (btnEnum == BtnEnum.withoutIcon)
          ? MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: onClicked,
            )
          : TextButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 16)),
              onPressed: onClicked,
              icon: icon,
              label: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
              ),
            ),
    );
  }
}
