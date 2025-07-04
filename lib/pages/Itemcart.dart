import 'package:flutter/material.dart';
import 'Reminder.dart';

class Itemcart extends StatelessWidget {
  final Reminder reminder;
  final bool isEnabled;
  final Function(bool) onToggle;

  const Itemcart({
    super.key, 
    required this.reminder,
    this.isEnabled = true,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final eventDate = reminder.date;
    final daysLeft = eventDate.difference(DateTime(now.year, now.month, now.day)).inDays;
    String formattedDate = "${_monthName(eventDate.month)} ${eventDate.day}";
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFF263D9A),
              child: Icon(Icons.calendar_today, color: Colors.white, size: 28),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.event,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '$formattedDate • $daysLeft days',
                    style: TextStyle(color: Color(0xFF263D9A), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Switch(
              value: isEnabled,
              onChanged: onToggle,
              activeColor: Color(0xFF263D9A),
            ),
          ],
        ),
      ),
    );
  }
}

String _monthName(int month) {
  const months = [
    '', 'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month];
}
