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
    Reminder(place: 'Tuy', event: 'Holy Thursday', date: DateTime(2025, 4, 3,)),
    Reminder(place: 'Tuy', event: 'Good Friday', date: DateTime(2025, 4, 4,)),
    Reminder(place: 'Tuy', event: 'Black Saturday', date: DateTime(2025, 4, 5,)),
    Reminder(place: 'Tuy', event: 'Easter Sunday', date: DateTime(2025, 4, 6,)),
    Reminder(place: 'Tuy', event: 'Christmas Mass', date: DateTime(2025, 12, 25,)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Church Occasions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: reminder.map((reminder) {
          return Itemcart(reminder: reminder);
        }).toList(),
      ),
    );
  }
}
