import 'package:flutter/material.dart';
import 'package:church_reminder/pages/Reminder.dart';
import 'Itemcart.dart';

// Static lists to persist data during app session
final List<Reminder> customReminders = [];
final Map<String, bool> customReminderStates = {};

class CustomReminder extends StatefulWidget {
  const CustomReminder({super.key});

  @override
  State<CustomReminder> createState() => _CustomReminderState();
}

class _CustomReminderState extends State<CustomReminder> {
  @override
  void initState() {
    super.initState();
    // Removed the duplicate alarm checker since it's handled globally in main.dart
  }

  void toggleCustomReminder(String eventName, bool value) {
    setState(() {
      customReminderStates[eventName] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1565C0),
        title: const Text(
          'Custom Reminder',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: customReminders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No custom reminders yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first reminder',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: customReminders.map((reminder) {
                return Itemcart(
                  reminder: reminder,
                  isEnabled: customReminderStates[reminder.event] ?? true,
                  onToggle: (value) => toggleCustomReminder(reminder.event, value),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add');
          if (result != null && result is Reminder) {
            setState(() {
              customReminders.add(result);
              customReminderStates[result.event] = true;
            });
          }
        },
        label: Text('Add Reminder'),
        icon: Icon(Icons.add),
        backgroundColor: Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
    );
  }
} 