import 'package:church_reminder/pages/Addreminder.dart';
import 'package:church_reminder/pages/Dashboard.dart';
import 'package:church_reminder/pages/ListItems.dart';
import 'package:church_reminder/pages/CustomReminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/' : (context) => Dashboard(),
      '/add' : (context) => Addreminder(),
      '/occasions' : (context) => Listitems(),
      '/custom-reminders' : (context) => CustomReminder(),
    }
  ));
}
