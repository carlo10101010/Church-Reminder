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
  final Map<String, int> _occasionAlertCounts = {}; // Track alert counts for occasions
  
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
    // Check Church Occasions
    final currentYear = now.year;
    final easter = _calculateEasterSunday(currentYear);
    
    final occasions = [
      // Fixed date occasions
      Reminder(place: '', event: 'Solemnity of Mary, Mother of God', date: DateTime(currentYear, 1, 1)),
      Reminder(place: '', event: 'Epiphany of the Lord', date: DateTime(currentYear, 1, 7)),
      Reminder(place: '', event: 'Baptism of the Lord', date: DateTime(currentYear, 1, 12)),
      Reminder(place: '', event: 'Presentation of the Lord', date: DateTime(currentYear, 2, 2)),
      Reminder(place: '', event: 'St. Joseph, Husband of Mary', date: DateTime(currentYear, 3, 19)),
      Reminder(place: '', event: 'Sacred Heart of Jesus', date: DateTime(currentYear, 6, 13)),
      Reminder(place: '', event: 'Saints Peter and Paul', date: DateTime(currentYear, 6, 29)),
      Reminder(place: '', event: 'Assumption of Mary', date: DateTime(currentYear, 8, 15)),
      Reminder(place: '', event: 'All Saints\' Day', date: DateTime(currentYear, 11, 1)),
      Reminder(place: '', event: 'All Souls\' Day', date: DateTime(currentYear, 11, 2)),
      Reminder(place: '', event: 'Christ the King', date: DateTime(currentYear, 11, 23)),
      Reminder(place: '', event: 'Immaculate Conception', date: DateTime(currentYear, 12, 8)),
      Reminder(place: '', event: 'Christmas Day', date: DateTime(currentYear, 12, 25)),
      Reminder(place: '', event: 'New Year\'s Eve Thanksgiving Mass', date: DateTime(currentYear, 12, 31)),
    ];
    
    // Add movable feasts (Easter-based)
    final movableFeasts = [
      Reminder(place: '', event: 'Ash Wednesday', date: easter.subtract(Duration(days: 46))),
      Reminder(place: '', event: 'Palm Sunday', date: easter.subtract(Duration(days: 7))),
      Reminder(place: '', event: 'Holy Thursday', date: easter.subtract(Duration(days: 3))),
      Reminder(place: '', event: 'Good Friday', date: easter.subtract(Duration(days: 2))),
      Reminder(place: '', event: 'Black Saturday', date: easter.subtract(Duration(days: 1))),
      Reminder(place: '', event: 'Easter Sunday', date: easter),
      Reminder(place: '', event: 'Ascension of the Lord', date: easter.add(Duration(days: 39))),
      Reminder(place: '', event: 'Pentecost Sunday', date: easter.add(Duration(days: 49))),
      Reminder(place: '', event: 'Holy Trinity Sunday', date: easter.add(Duration(days: 56))),
      Reminder(place: '', event: 'Corpus Christi', date: easter.add(Duration(days: 60))),
    ];
    
    final allOccasions = [...occasions, ...movableFeasts];
    
    for (final occasion in allOccasions) {
      // Check if today is the occasion day
      if (occasion.date.year == now.year &&
          occasion.date.month == now.month &&
          occasion.date.day == now.day) {
        
        // Create a unique key for this occasion on this day
        final occasionKey = '${occasion.event}_${now.year}_${now.month}_${now.day}';
        
        // Initialize alert count if not exists
        if (!_occasionAlertCounts.containsKey(occasionKey)) {
          _occasionAlertCounts[occasionKey] = 0;
        }
        
        // Check if we should alert (every 5 minutes, max 3 times)
        final alertCount = _occasionAlertCounts[occasionKey]!;
        if (alertCount < 3) {
          // Calculate if it's time for the next alert
          // First alert at 6:30 AM, then every 5 minutes
          final firstAlertTime = DateTime(now.year, now.month, now.day, 6, 30);
          final minutesSinceFirstAlert = now.difference(firstAlertTime).inMinutes;
          
          // Alert at 0, 5, and 10 minutes (3 times total)
          if (minutesSinceFirstAlert >= 0 && 
              minutesSinceFirstAlert % 5 == 0 && 
              minutesSinceFirstAlert <= 10) {
            
            // Check if we haven't already alerted for this specific time
            final timeKey = '${occasionKey}_${minutesSinceFirstAlert}';
            if (!_playedReminders.contains(timeKey.hashCode)) {
              await _audioPlayer.play(AssetSource('alarmmm.mp3'));
              _playedReminders.add(timeKey.hashCode);
              _occasionAlertCounts[occasionKey] = alertCount + 1;
              _showReminderDialog(occasion.event);
            }
          }
        }
      }
    }
  });
}

// Helper function to calculate Easter Sunday
DateTime _calculateEasterSunday(int year) {
  int a = year % 19;
  int b = year ~/ 100;
  int c = year % 100;
  int d = b ~/ 4;
  int e = b % 4;
  int f = (b + 8) ~/ 25;
  int g = (b - f + 1) ~/ 3;
  int h = (19 * a + b - d - g + 15) % 30;
  int i = c ~/ 4;
  int k = c % 4;
  int l = (32 + 2 * e + 2 * i - h - k) % 7;
  int m = (a + 11 * h + 22 * l) ~/ 451;
  int month = (h + l - 7 * m + 114) ~/ 31;
  int day = ((h + l - 7 * m + 114) % 31) + 1;
  return DateTime(year, month, day);
}

void _showReminderDialog(String event) {
  final context = globalNavigatorKey.currentContext;
  if (context == null) return;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
        child: Text(
          'Reminder',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      content: Text(
        'It\'s time for: $event',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
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
