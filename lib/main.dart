import 'package:church_reminder/pages/Addreminder.dart';
import 'package:church_reminder/pages/Dashboard.dart';
import 'package:church_reminder/pages/ListItems.dart';
import 'package:church_reminder/pages/CustomReminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'pages/Reminder.dart';
import 'pages/CustomReminder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
final AudioPlayer globalAudioPlayer = AudioPlayer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Request notification permission for Android 13+
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  runApp(MyApp());
  startGlobalReminderChecker();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: globalNavigatorKey,
      routes: {
        '/' : (context) => Dashboard(),
        '/add' : (context) => Addreminder(),
        '/occasions' : (context) => Listitems(),
        '/custom-reminders' : (context) => CustomReminder(),
      }
    );
  }
}

void startGlobalReminderChecker() {
  final AudioPlayer _audioPlayer = globalAudioPlayer;
  final Set<int> _playedReminders = {};
  Timer.periodic(Duration(seconds: 1), (timer) async {
    final now = DateTime.now();
    // Check Sunday Reminder
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getInt('_reminderHourKey') ?? 6;
    final minute = prefs.getInt('_reminderMinuteKey') ?? 30;
    if (now.weekday == DateTime.sunday &&
        now.hour == hour &&
        now.minute == minute) {
      final key = now.year * 100000000 + now.month * 1000000 + now.day * 10000 + now.hour * 100 + now.minute + 1000000000;
      if (!_playedReminders.contains(key)) {
        await _audioPlayer.play(AssetSource('alarmmm.mp3'));
        _playedReminders.add(key);
        _showReminderDialog('Sunday Church Reminder');
      }
    }
    // Check Custom Reminders
    for (final reminder in customReminders) {
      final isEnabled = customReminderStates[reminder.event] ?? true;
      if (!isEnabled) continue;
      final key = reminder.hashCode ^ (now.year * 100000000 + now.month * 1000000 + now.day * 10000 + now.hour * 100 + now.minute);
      if (reminder.date.year == now.year &&
          reminder.date.month == now.month &&
          reminder.date.day == now.day &&
          reminder.date.hour == now.hour &&
          reminder.date.minute == now.minute &&
          !_playedReminders.contains(key)) {
        await _audioPlayer.play(AssetSource('alarmmm.mp3'));
        _playedReminders.add(key);
        _showReminderDialog(reminder.event);
      }
    }
  });
}

void _showReminderDialog(String event) {
  final context = globalNavigatorKey.currentContext;
  if (context == null) return;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Reminder'),
      content: Text('It\'s time for: $event'),
      actions: [
        TextButton(
          onPressed: () {
            globalAudioPlayer.stop();
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}
