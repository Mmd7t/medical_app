import 'dart:async';
import 'dart:math';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/splash_screen.dart';
import 'package:medical_app/widgets/global_btn.dart';
import 'package:medical_app/widgets/main_template.dart';
import 'package:medical_app/widgets/notifications.dart';
import '../constants.dart';

class CalculateWaterPage extends StatefulWidget {
  static const String routeName = 'calculateWaterPage';

  @override
  _CalculateWaterPageState createState() => _CalculateWaterPageState();
}

class _CalculateWaterPageState extends State<CalculateWaterPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String water = 'data';
  String weight;
  double result = 0;
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MainTemplate(
      isHome: false,
      title: 'حساب شرب الماء',
      child: Center(
        child: NotificationListener(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowGlow();
            return;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 2000),
                      reverseDuration: const Duration(milliseconds: 2000),
                      firstChild: const Text(
                        'حساب عدد أكواب الماء',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Constants.darkColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.fontName,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      secondChild: Text(
                        water,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Constants.darkColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: Constants.fontName,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                      firstCurve: Curves.easeInOutBack,
                      secondCurve: Curves.easeInOutBack,
                      crossFadeState: crossFadeState,
                    ),
                  ),
                ),
/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------  TextField  -----------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45)
                      .copyWith(top: 30),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'ادخل وزنك',
                        filled: true,
                        fillColor: Constants.textFieldColor,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'من فضلك ادخل وزنك';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        setState(() {
                          weight = newValue;
                        });
                      },
                    ),
                  ),
                ),
/*-----------------------------------------------------------------------------------------------*/
/*------------------------------------------  Button  -------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/
                const SizedBox(height: 40),
                GlobalBtn(
                  text: 'احسب',
                  width: size.width * 0.4,
                  onClicked: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        result = (30 * double.parse(weight)) / 250;
                        water =
                            'عدد اكواب الماء التى يحتاجها جسمك ${result.toStringAsFixed(0)} باليوم';
                        crossFadeState = CrossFadeState.showSecond;
                      });

                      Timer(const Duration(seconds: 3), () {
                        setState(() {
                          crossFadeState = CrossFadeState.showFirst;
                        });
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                (result != 0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GlobalBtn.icon(
                            text: 'تذكير',
                            icon: const Icon(
                              Icons.alarm_on_outlined,
                              color: Colors.white,
                            ),
                            width: size.width * 0.45,
                            onClicked: () {
                              AndroidAlarmManager.periodic(
                                      Duration(hours: 24 ~/ result),
                                      Random().nextInt(pow(2, 31).toInt()),
                                      callback,
                                      wakeup: true,
                                      rescheduleOnReboot: true)
                                  .then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('تم تشغيل الاشعارات'),
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          GlobalBtn.icon(
                            text: 'ايقاف',
                            icon: const Icon(
                              Icons.alarm_off_outlined,
                              color: Colors.white,
                            ),
                            width: size.width * 0.45,
                            onClicked: () {
                              AndroidAlarmManager.cancel(
                                      Random().nextInt(pow(2, 31).toInt()))
                                  .then((value) {
                                notificationPlugin.cancelAllNotification();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('تم ايقاف الاشعارات'),
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
    Navigator.of(context).pushNamed(SplashScreen.routeName);
  }
}

void callback() {
  notificationPlugin.showNotification();
}
