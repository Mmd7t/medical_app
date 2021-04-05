import 'package:flutter/material.dart';

import '../../constants.dart';

class SignBtn extends StatelessWidget {
  final String text;
  final Function onClicked;

  const SignBtn({Key key, this.text, this.onClicked}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.button.copyWith(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // color: Theme.of(context).accentColor,
        onPressed: onClicked,
      ),
    );
  }
}
