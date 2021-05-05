import 'package:flutter/material.dart';
import 'package:medical_app/widgets/main_template.dart';
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
                Template(
                  titles: [
                    'اللحوم وبدائله',
                    'الخبز والنشويات',
                    'الدهون',
                    'الخضروات  والفواكه',
                    'المشروبات والأعشاب'
                  ],
                  data: [
                    ['بياض البيض', 'فول مقشر 3ملاعق كبيرة'],
                    ['نشأ الذرة –سكر المائدة', 'العسل الأبيض- المربى'],
                    [
                      'الزيوت النباتية – (زيت الزيتون-زيت الذرة-زيت بذرة القطن)'
                    ],
                    [
                      'لوبيا خضراء – كوسا',
                      'فاصولياء خضراء - تفاح',
                      'الألبان ومنتجاتها',
                    ],
                    ['المشروبات الطبيعية (الشاي الأخضر-الينسون-الشمر)'],
                  ],
                ),
                const SizedBox(height: 10),
                headline('غذاء مسموح من مره الى مرتين في اليوم', context),
                Template(
                  titles: [
                    'اللحوم وبدائله',
                    'الخبز والنشويات',
                    'الخضروات  والفواكه',
                    'الدهون',
                    'المشروبات والأعشاب'
                  ],
                  data: [
                    ['قرص طعمية –سمك ابيض', 'دجاج'],
                    [
                      'المكرونة او الأرز- الخبز الشامي',
                      'الكورن فليكس (رقائق الذرة)',
                      'الخبز اللبناني',
                      'كوب صغير من اللبن او الزبادي خالي الدسم',
                      'قطعة جبن قريش في حجم البيضة',
                    ],
                    [
                      'فلفل أخضر-بازيلاء',
                      'خيار بدون قشره – ثمره صغيرة من الطماطم'
                    ],
                    [
                      'الزيوت النباتية – (زيت الزيتون-زيت الذرة-زيت بذرة القطن)'
                    ],
                    ['التوابل مثل الكمون والكزبرة بمعدل 2-3 ملاعق صغيرة'],
                  ],
                ),
                const SizedBox(height: 10),
                headline('غذاء مسموح من ثلاث الى أربع مرت في اليوم', context),
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
                    ['فول مدمس', 'مكرونة', 'سمك'],
                    ['الخبز البلدي', 'مسحوق البقسماط العادي'],
                    [
                      'من 4-5 ملاعق من الفول السوداني-البندق(الغير محمص)-اللوز الغير محمص'
                    ],
                    [
                      'البامية-الخس-الجزر',
                      'الكاكا-الجوافة',
                    ],
                    ['ملعقة صغيرة من الزنجبيل- قرنفل'],
                    ['جبنه بيضاء نصف دسمة بحجم البيضة'],
                  ],
                ),
                const SizedBox(height: 10),
                headline('غذاء مسموح من مرتين الى ثلاث مرات في الشهر', context),
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
                    [
                      'البيض الكامل (صفار+ البيض)',
                      'الجمبري-الديك الرومي- الكبدة (في حجم البيضة)',
                    ],
                    [
                      'التوست الأسمر –البليلة (القمح الكامل)',
                      'حبوب الشعير – منتجات دقيق الذرة',
                    ],
                    ['القشدة', 'من3-4 حبات من المكسرات', 'زبدة'],
                    ['المشروم'],
                    ['الكاكو أو مسحوق الشوكولاتة'],
                    ['كوب صغير من اللبن الرائب', 'كوب من الايس كريم'],
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
