import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  NotificationPlugin._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );

    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

/*-----------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Show Notification  ---------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  Future<void> showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(pow(2, 31).toInt()),
      'مرضى الفشل الكلوى',
      'من فضلك اشرب الماء الآن', //null
      platformChannelSpecifics,
      payload: 'New Payload for simple Notification',
    );
  }

/*-----------------------------------------------------------------------------------------------------*/
/*-------------------------------------  Show Message Notification  -----------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  Future<void> showMessageNotification(title, message) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(pow(2, 31).toInt()),
      title,
      message, //null
      platformChannelSpecifics,
      payload: 'New Payload for simple Message Notification',
    );
  }

/*-----------------------------------------  Cancel Notification  -------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

/*-----------------------------------------------------------------------------------------------------*/
/*---------------------------------------  Cancel All Notification  -----------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
