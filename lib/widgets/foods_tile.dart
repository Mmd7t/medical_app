import 'package:flutter/material.dart';
import '../constants.dart';

class FoodsTile extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  final bool isPotassiumFood;

  const FoodsTile({
    Key key,
    this.img,
    this.title,
    this.subTitle,
    this.isPotassiumFood,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: size.width * 0.3,
              height: size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(img, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            (isPotassiumFood)
                ? Text(
                    title,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.subtitle1.fontSize - 2,
                      color: Constants.darkColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constants.fontName,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline6.fontSize -
                                  4,
                          color: Constants.darkColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.fontName,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(subTitle),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
