import 'package:flutter/material.dart';
import 'Addreminder.dart';

class Dashboard extends StatelessWidget {
  final Color primaryColor = Color(0xFF1565C0); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Church Reminder', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Quick Actions
                Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ActionCard(
                          icon: Icons.church,
                          label: 'Sunday Reminder',
                          subLabel: 'Set weekly reminder',
                          iconSize: 40,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/occasions');
                          },
                          child: ActionCard(
                            icon: Icons.event,
                            label: 'Occasions',
                            subLabel: 'View church events',
                            iconSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/custom-reminders');
                    },
                    icon: Icon(Icons.list),
                    label: Text('View Reminders'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Upcoming Events
                Text("Upcoming Church Events", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                EventItem(
                  title: 'Assumption of Mary',
                  date: 'Aug 15, Fri',
                  daysLeft: 45,
                ),
                EventItem(
                  title: 'All Saints\' Day',
                  date: 'Nov 1, Sat',
                  daysLeft: 123,
                ),
                EventItem(
                  title: 'All Souls\' Day',
                  date: 'Nov 2, Sun',
                  daysLeft: 124,
                ),
                EventItem(
                  title: 'Christ the King',
                  date: 'Nov 23, Sun',
                  daysLeft: 145,
                ),
                EventItem(
                  title: 'Immaculate Conception',
                  date: 'Dec 8, Mon',
                  daysLeft: 160,
                ),
                EventItem(
                  title: 'Simbang Gabi (Dawn Masses)',
                  date: 'Dec 16-24',
                  daysLeft: 168,
                ),
                EventItem(
                  title: 'Christmas Day',
                  date: 'Dec 25, Thu',
                  daysLeft: 177,
                ),
                EventItem(
                  title: 'New Year\'s Eve Thanksgiving Mass',
                  date: 'Dec 31, Wed',
                  daysLeft: 183,
                ),
              ],
            ),
          ),
        ),
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

  const ActionCard({
    required this.icon,
    required this.label,
    required this.subLabel,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$date • $daysLeft days'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}