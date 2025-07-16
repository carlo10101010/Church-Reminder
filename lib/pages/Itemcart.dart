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
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
    final daysDiff = eventDay.difference(today).inDays;
    String formattedDate = "${_monthName(eventDate.month)} ${eventDate.day}";
    String daysText;
    if (daysDiff > 0) {
      daysText = "$daysDiff days";
    } else if (daysDiff == 0) {
      daysText = "Today";
    } else {
      daysText = "${-daysDiff} days ago";
    }
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
              backgroundColor: (eventDate.isBefore(now)) ? Colors.red : (isEnabled ? Color(0xFF263D9A) : Colors.grey[400]),
              child: Icon(
                eventDate.isBefore(now)
                  ? Icons.close
                  : (isEnabled ? Icons.calendar_today : Icons.event_busy),
                color: Colors.white,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.event,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: eventDate.isBefore(now) ? Colors.red : null,
                      decoration: isEnabled ? null : TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '$formattedDate • $daysText',
                    style: TextStyle(
                      color: eventDate.isBefore(now) ? Colors.red : Color(0xFF263D9A),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: eventDate.isBefore(now) ? false : isEnabled,
              onChanged: eventDate.isBefore(now) ? null : onToggle,
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
