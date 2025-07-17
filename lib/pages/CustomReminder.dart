import 'package:flutter/material.dart';
import 'package:church_reminder/pages/Reminder.dart';
import 'Itemcart.dart';
import 'package:audioplayers/audioplayers.dart';

// Static lists to persist data during app session
final List<Reminder> customReminders = [];
final Map<String, bool> customReminderStates = {};

class CustomReminder extends StatefulWidget {
  const CustomReminder({super.key});

  @override
  State<CustomReminder> createState() => _CustomReminderState();
}

class _CustomReminderState extends State<CustomReminder> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Set<int> _playedReminders = {};
  @override
  void initState() {
    super.initState();
    _startCustomReminderChecker();
  }

  void _startCustomReminderChecker() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      final now = DateTime.now();
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
          _playAlertSound();
          _playedReminders.add(key);
        }
      }
      return mounted;
    });
  }

  Future<void> _playAlertSound() async {
    await _audioPlayer.play(AssetSource('alarmmm.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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