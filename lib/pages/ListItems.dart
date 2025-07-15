import 'package:flutter/material.dart';
import 'package:church_reminder/pages/Reminder.dart';
import 'Itemcart.dart';

class Listitems extends StatefulWidget {
  const Listitems({super.key});

  @override
  State<Listitems> createState() => _ListitemsState();
}

class _ListitemsState extends State<Listitems> {
  final List<Reminder> reminder = [
    Reminder(place: 'Tuy', event: 'Solemnity of Mary, Mother of God', date: DateTime(2025, 1, 1)),
    Reminder(place: 'Tuy', event: 'Epiphany of the Lord', date: DateTime(2025, 1, 7)),
    Reminder(place: 'Tuy', event: 'Baptism of the Lord', date: DateTime(2025, 1, 12)),
    Reminder(place: 'Tuy', event: 'Presentation of the Lord', date: DateTime(2025, 2, 2)),
    Reminder(place: 'Tuy', event: 'Ash Wednesday', date: DateTime(2025, 2, 26)),
    Reminder(place: 'Tuy', event: 'St. Joseph, Husband of Mary', date: DateTime(2025, 3, 19)),
    Reminder(place: 'Tuy', event: 'Palm Sunday', date: DateTime(2025, 3, 30)),
    Reminder(place: 'Tuy', event: 'Holy Thursday', date: DateTime(2025, 4, 3)),
    Reminder(place: 'Tuy', event: 'Good Friday', date: DateTime(2025, 4, 4)),
    Reminder(place: 'Tuy', event: 'Black Saturday', date: DateTime(2025, 4, 5)),
    Reminder(place: 'Tuy', event: 'Easter Sunday', date: DateTime(2025, 4, 6)),
    Reminder(place: 'Tuy', event: 'Ascension of the Lord', date: DateTime(2025, 5, 11)),
    Reminder(place: 'Tuy', event: 'Pentecost Sunday', date: DateTime(2025, 5, 18)),
    Reminder(place: 'Tuy', event: 'Holy Trinity Sunday', date: DateTime(2025, 5, 25)),
    Reminder(place: 'Tuy', event: 'Corpus Christi', date: DateTime(2025, 6, 1)),
    Reminder(place: 'Tuy', event: 'Sacred Heart of Jesus', date: DateTime(2025, 6, 13)),
    Reminder(place: 'Tuy', event: 'Saints Peter and Paul', date: DateTime(2025, 6, 29)),
    Reminder(place: 'Tuy', event: 'Assumption of Mary', date: DateTime(2025, 8, 15)),
    Reminder(place: 'Tuy', event: 'All Saints\' Day', date: DateTime(2025, 11, 1)),
    Reminder(place: 'Tuy', event: 'All Souls\' Day', date: DateTime(2025, 11, 2)),
    Reminder(place: 'Tuy', event: 'Christ the King', date: DateTime(2025, 11, 23)),
    Reminder(place: 'Tuy', event: 'Immaculate Conception', date: DateTime(2025, 12, 8)),
    Reminder(place: 'Tuy', event: 'Simbang Gabi (Dawn Masses)', date: DateTime(2025, 12, 16)),
    Reminder(place: 'Tuy', event: 'Christmas Day', date: DateTime(2025, 12, 25)),
    Reminder(place: 'Tuy', event: 'New Year\'s Eve Thanksgiving Mass', date: DateTime(2025, 12, 31)),
  ];

  Map<String, bool> occasionStates = {};

  @override
  void initState() {
    super.initState();
    for (var occasion in reminder) {
      occasionStates[occasion.event] = true;
    }
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
          );
        }).toList(),
      ),
    );
  }
}
