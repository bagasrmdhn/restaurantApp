import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';
import 'package:subtiga_restaurant/ui/detail_page.dart';

final selectNotificationSubject = BehaviorSubject<String>();
final random = Random();
int min = 0;
int max = 20;
var _random = min + random.nextInt(max - min);


class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            print('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload ?? 'empty payload');
        });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantsResult restaurantList) async {
    var _channelId = "1";
    var _channelName = "channel_01";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotifications = "<b>Lihat Restaurant Terbaru Ini!</b>";
    var titleRestaurant = restaurantList.restaurants[_random].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotifications, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurantList.toJson()));
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen(
          (String payload) async {
        var data = RestaurantsResult.fromJson(json.decode(payload));
        var restaurant = data.restaurants[0];
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant.id);
      },
    );
  }
}
