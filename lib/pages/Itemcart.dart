import 'package:flutter/material.dart';
import 'Reminder.dart';

class Itemcart extends StatelessWidget {
  final Reminder reminder;
  final bool isEnabled;
  final Function(bool) onToggle;
  final bool showPastEventStyling;

  const Itemcart({
    super.key, 
    required this.reminder,
    this.isEnabled = true,
    required this.onToggle,
    this.showPastEventStyling = true,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final eventDate = reminder.date;
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
    final daysDiff = eventDay.difference(today).inDays;
    final isPast = eventDate.isBefore(now);
    
    String formattedDate = "${_monthName(eventDate.month)} ${eventDate.day}";
    String daysText;
    if (daysDiff > 0) {
      daysText = "$daysDiff days";
    } else if (daysDiff == 0) {
      daysText = "Today";
    } else {
      daysText = "${-daysDiff} days ago";
    }
    
    // Determine styling based on showPastEventStyling parameter
    final shouldApplyPastStyling = showPastEventStyling && isPast;
    
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
              backgroundColor: shouldApplyPastStyling ? Colors.grey[400] : (isEnabled ? Color(0xFF263D9A) : Colors.grey[400]),
              child: Icon(
                shouldApplyPastStyling
                  ? Icons.event_busy
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
                      color: shouldApplyPastStyling ? Colors.grey[600] : null,
                      decoration: !isEnabled ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '$formattedDate • $daysText',
                    style: TextStyle(
                      color: shouldApplyPastStyling ? Colors.grey[500] : Color(0xFF263D9A),
                      fontWeight: FontWeight.normal,
                      decoration: !isEnabled ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isPast ? false : isEnabled,
              onChanged: isPast ? null : onToggle,
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
