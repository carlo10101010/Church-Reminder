import 'package:flutter/material.dart';

class Reminder {
  final String place;
  final String event;
  final DateTime date;

  Reminder({required this.place, required this.event, required this.date});
}

class SundayReminderPage extends StatefulWidget {
  const SundayReminderPage({Key? key}) : super(key: key);

  @override
  State<SundayReminderPage> createState() => _SundayReminderPageState();
}

class _SundayReminderPageState extends State<SundayReminderPage> with TickerProviderStateMixin {
  bool isReminderEnabled = true;
  TimeOfDay reminderTime = const TimeOfDay(hour: 6, minute: 30);

  // Controllers for horizontal scroll animations
  final ScrollController _frequencyController = ScrollController();
  final ScrollController _notificationController = ScrollController();
  final ScrollController _noteController = ScrollController();

  late AnimationController _frequencyAnim;
  late AnimationController _notificationAnim;
  late AnimationController _noteAnim;

  @override
  void initState() {
    super.initState();
    _frequencyAnim = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _notificationAnim = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _noteAnim = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScrolls());
  }

  void _startAutoScrolls() {
    _autoScroll(_frequencyController, _frequencyAnim);
    _autoScroll(_notificationController, _notificationAnim);
    _autoScroll(_noteController, _noteAnim);
  }

  void _autoScroll(ScrollController controller, AnimationController anim) async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (!controller.hasClients) continue;
      final maxScroll = controller.position.maxScrollExtent;
      if (maxScroll > 0) {
        await controller.animateTo(
          maxScroll,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
        await Future.delayed(const Duration(seconds: 1));
        await controller.animateTo(
          0,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );
    if (picked != null && picked != reminderTime) {
      setState(() {
        reminderTime = picked;
      });
    }
  }

  String get formattedTime {
    final hour = reminderTime.hourOfPeriod == 0 ? 12 : reminderTime.hourOfPeriod;
    final minute = reminderTime.minute.toString().padLeft(2, '0');
    final period = reminderTime.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    _frequencyController.dispose();
    _notificationController.dispose();
    _noteController.dispose();
    _frequencyAnim.dispose();
    _notificationAnim.dispose();
    _noteAnim.dispose();
    super.dispose();
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
          'Sunday Reminder',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
        ],
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Weekly Church Reminder Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3ECFA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.church, color: Color(0xFF1565C0), size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Weekly Church Reminder',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Get reminded every Sunday to attend church service',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Enable Sunday Reminder Switch
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Enable Sunday Reminder',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Receive notifications every Sunday',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  Switch(
                    value: isReminderEnabled,
                    onChanged: (val) {
                      setState(() {
                        isReminderEnabled = val;
                      });
                    },
                    activeColor: Color(0xFF1565C0),
                  ),
                ],
              ),
            ),
            if (isReminderEnabled) ...[
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0.5,
                child: ListTile(
                  leading: const Icon(Icons.access_time, color: Color(0xFF1565C0)),
                  title: const Text('Reminder Time', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text('Every Sunday at $formattedTime'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _pickTime,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reminder Details',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.repeat, size: 22, color: Colors.black54),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Frequency', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 2),
                              const Text('Every Sunday', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notifications_active, size: 22, color: Colors.black54),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Notification', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 2),
                              const Text('Local notification', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline, size: 22, color: Colors.black54),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Note', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 2),
                              const Text('Reminder will continue until disabled', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}