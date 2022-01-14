import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subtiga_restaurant/provider/database_provider.dart';
import 'package:subtiga_restaurant/provider/preferences_provider.dart';
import 'package:subtiga_restaurant/provider/restaurant_detail_provider.dart';
import 'package:subtiga_restaurant/provider/restaurant_favorite_provider.dart';
import 'package:subtiga_restaurant/provider/restaurant_list_provider.dart';
import 'package:subtiga_restaurant/provider/restaurant_search_provider.dart';
import 'package:subtiga_restaurant/provider/scheduling_provider.dart';
import 'package:subtiga_restaurant/ui/detail_page.dart';
import 'package:subtiga_restaurant/ui/home_page.dart';
import 'package:subtiga_restaurant/ui/main_page.dart';
import 'package:subtiga_restaurant/ui/search_page.dart';
import 'package:subtiga_restaurant/ui/favorite_page.dart';
import 'package:subtiga_restaurant/ui/setting_page.dart';
import 'package:subtiga_restaurant/utils/background_services.dart';
import 'package:subtiga_restaurant/utils/notification_helper.dart';

import 'data/api/api_service.dart';
import 'data/lokal/database_helper.dart';
import 'data/lokal/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<RestaurantsFavoriteProvider>(
            create: (_) => RestaurantsFavoriteProvider(
                  databaseHelper: DatabaseHelper(),
                )
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MainPage.routeName,
        routes: {
          MainPage.routeName: (context) => const MainPage(),
          HomePage.routeName: (context) => const HomePage(),
          // SearchBar.routeName: (context) =>  SearchBar(),
          FavoritePage.routeName: (contex) => const FavoritePage(),
          SearchPage.routeName: (contex) => const SearchPage(),
          SettingPage.routeName: (context) => const SettingPage(),
          DetailPage.routeName: (context) =>
              DetailPage(id: ModalRoute.of(context).settings.arguments),
        },
      ),
    );
  }
}
