import 'package:flutter/material.dart';
import 'package:church_reminder/pages/Reminder.dart';
import 'Itemcart.dart';

class Listitems extends StatefulWidget {
  const Listitems({super.key});

  @override
  State<Listitems> createState() => _ListitemsState();
}

class _ListitemsState extends State<Listitems> {
  late List<Reminder> reminder;
  Map<String, bool> occasionStates = {};

  @override
  void initState() {
    super.initState();
    _generateOccasionsForCurrentYear();
    for (var occasion in reminder) {
      occasionStates[occasion.event] = true;
    }
  }

  void _generateOccasionsForCurrentYear() {
    final currentYear = DateTime.now().year;
    final easter = _calculateEasterSunday(currentYear);
    
    reminder = [
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
      Reminder(place: '', event: 'Simbang Gabi (Dawn Masses)', date: DateTime(currentYear, 12, 16)),
      Reminder(place: '', event: 'Christmas Day', date: DateTime(currentYear, 12, 25)),
      Reminder(place: '', event: 'New Year\'s Eve Thanksgiving Mass', date: DateTime(currentYear, 12, 31)),
      
      // Movable feasts (Easter-based)
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
    
    // Sort occasions by date
    reminder.sort((a, b) => a.date.compareTo(b.date));
  }

  // Helper function to calculate Easter Sunday for any year
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

  void toggleOccasion(String eventName, bool value) {
    setState(() {
      occasionStates[eventName] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Church Occasions',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal),
        ),
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
      ),
      body: ListView(
        children: reminder.map((reminder) {
          return Itemcart(
            reminder: reminder,
            isEnabled: occasionStates[reminder.event] ?? true,
            onToggle: (value) => toggleOccasion(reminder.event, value),
            showPastEventStyling: false,
          );
        }).toList(),
      ),
    );
  }
}
