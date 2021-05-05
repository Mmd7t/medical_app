import 'package:flutter/material.dart';
import 'package:medical_app/widgets/main_template.dart';
import '../../constants.dart';

class ForbiddenFood extends StatelessWidget {
  static const String routeName = 'forbiddenfood';
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      isHome: false,
      title: 'الأغذية الممنوعة',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Template(
                  titles: [
                    'اللحوم وبدائله',
                    'الخبز والنشويات',
                    'الدهون',
                    'الخضروات  والفواكه',
                    'المشروبات والأعشاب',
                    'الألبان ومنتجاتها'
                  ],
                  data: [
                    ['صفار البيض', 'البرجر', 'السجق', 'البلوبيف'],
                    [
                      'الردة',
                      'الحلاوة الطحينية',
                      'المخبوزات',
                      'الفريك',
                      'البرغل',
                      'الكرواسون'
                    ],
                    ['المايونيز', 'الطحينية ومنتجاتها ', 'زبدة الفول السوداني'],
                    [
                      'الخضروات المعلبه',
                    ],
                    ['جميع المشروبات الغازية', 'مرق الدجاج', 'البكينج باودر'],
                    [
                      'الجبن المثلثات',
                      'الجبن الرومي',
                      'الجبن المطبوخ ',
                      ' جبنة الموتزريلا والشيدر',
                      ' اللبن كامل الدسم والشوكولاتا'
                    ],
                  ],
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
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.headline6.fontSize - 2,
        color: Constants.darkColor,
        fontWeight: FontWeight.bold,
        fontFamily: Constants.fontName,
      ),
    );
  }
}

class Template extends StatelessWidget {
  final List titles;
  final List<List> data;

  const Template({Key key, this.titles, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: titles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6 / 6,
      ),
      itemBuilder: (context, index) {
        return LayoutBuilder(builder: (context, constraints) {
          return Card(
            elevation: 2.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).accentColor,
                      Constants.color2,
                    ], begin: Alignment.centerRight, end: Alignment.centerLeft),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    titles[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data[index].length,
                    itemBuilder: (context, indexx) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data[index][indexx]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
