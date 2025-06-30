import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final Color primaryColor = Color(0xFF263D9A); // Navy blue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Church Reminder'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Good Morning Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.indigo[400],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Stay connected with your faith journey',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Thursday, June 26, 2025',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Quick Actions
              Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),  // Same margin on both sides
                      child: ActionCard(
                        icon: Icons.church,
                        label: 'Sunday Reminder',
                        subLabel: 'Set weekly reminder',
                        iconSize: 40,
                        height: 140,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),  // Same margin on both sides
                      child: ActionCard(
                        icon: Icons.event,
                        label: 'Occasions',
                        subLabel: 'View church events',
                        iconSize: 40,
                        height: 140,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Upcoming Events
              Text("Upcoming Church Events", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              EventItem(title: 'Christmas', date: 'December 25', daysLeft: 181),
              EventItem(title: 'Easter', date: 'April 9', daysLeft: 286),
              EventItem(title: 'Good Friday', date: 'April 7', daysLeft: 284),
            ],
          ),
        ),
      ),

      // Add Reminder Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Add Reminder'),
        icon: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}

// COMPONENTS

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final double iconSize;
  final double height;

  const ActionCard({
    required this.icon,
    required this.label,
    required this.subLabel,
    this.iconSize = 28,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize, color: Colors.indigo[800]),
          SizedBox(height: 10),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(subLabel,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black54)),
        ],
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String title;
  final String date;
  final int daysLeft;

  const EventItem({required this.title, required this.date, required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo[700],
          child: Icon(Icons.calendar_today, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text('$date • $daysLeft days'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}