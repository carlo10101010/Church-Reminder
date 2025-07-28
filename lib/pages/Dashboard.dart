import 'package:flutter/material.dart';
import 'Addreminder.dart';
import 'Reminder.dart';
import 'dart:async'; 
import 'package:table_calendar/table_calendar.dart';
import 'ListItems.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = _formattedTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _formattedTime();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formattedTime() {
    final now = DateTime.now();
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  final Color primaryColor = Color(0xFF1565C0); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Church Reminder', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChurchCalendarPage()),
              );
            },
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
                    gradient: LinearGradient(
                      colors: [Color(0xFF4F6DAD), Color(0xFF6A8EDB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Stay connected with your faith journey',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _formattedToday(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _currentTime,
                        style: TextStyle(color: Colors.white, fontSize: 15),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SundayReminderPage()),
                            );
                          },
                          child: ActionCard(
                            icon: Icons.church,
                            label: 'Sunday Reminder',
                            subLabel: 'Set weekly reminder',
                            iconSize: 40,
                          ),
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
                  daysLeftText: _daysLeftText(_parseEventDate('Aug 15, Fri')),
                ),
                EventItem(
                  title: 'All Saints\' Day',
                  date: 'Nov 1, Sat',
                  daysLeftText: _daysLeftText(_parseEventDate('Nov 1, Sat')),
                ),
                EventItem(
                  title: 'All Souls\' Day',
                  date: 'Nov 2, Sun',
                  daysLeftText: _daysLeftText(_parseEventDate('Nov 2, Sun')),
                ),
                EventItem(
                  title: 'Christ the King',
                  date: 'Nov 23, Sun',
                  daysLeftText: _daysLeftText(_parseEventDate('Nov 23, Sun')),
                ),
                EventItem(
                  title: 'Immaculate Conception',
                  date: 'Dec 8, Mon',
                  daysLeftText: _daysLeftText(_parseEventDate('Dec 8, Mon')),
                ),
                EventItem(
                  title: 'Simbang Gabi (Dawn Masses)',
                  date: 'Dec 16-24',
                  daysLeftText: _daysLeftText(_parseEventDate('Dec 16-24')),
                ),
                EventItem(
                  title: 'Christmas Day',
                  date: 'Dec 25, Thu',
                  daysLeftText: _daysLeftText(_parseEventDate('Dec 25, Thu')),
                ),
                EventItem(
                  title: 'New Year\'s Eve Thanksgiving Mass',
                  date: 'Dec 31, Wed',
                  daysLeftText: _daysLeftText(_parseEventDate('Dec 31, Wed')),
                ),
                SizedBox(height: 20), // Extra space after last occasion
                // Sunday Church Reminder card with green notification bell (scrolls with content)
                FutureBuilder<TimeOfDay>(
                  future: SundayReminderPage.getSavedReminderTime(),
                  builder: (context, snapshot) {
                    final time = snapshot.data ?? TimeOfDay(hour: 6, minute: 30);
                    String formattedTime = _formatTimeOfDay(time);
                    return Card(
                      elevation: 0,
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF43A047),
                          radius: 22,
                          child: Icon(Icons.notifications_active, color: Colors.white, size: 28),
                        ),
                        title: Text(
                          'Sunday Church Reminder',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        subtitle: Text('Every Sunday at $formattedTime'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SundayReminderPage()),
                          ).then((_) => setState(() {}));
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // Add Sunday Church Reminder card after the scrollable content
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      //   child: Card(
      //     elevation: 0,
      //     margin: EdgeInsets.zero,
      //     child: ListTile(
      //       leading: CircleAvatar(
      //         backgroundColor: Colors.green[800],
      //         radius: 22,
      //         child: Icon(Icons.notifications, color: Colors.white, size: 28),
      //       ),
      //       title: Text(
      //         'Sunday Church Reminder',
      //         style: TextStyle(fontWeight: FontWeight.normal),
      //       ),
      //       subtitle: Text('Every Sunday at 6:30 AM'),
      //       trailing: Icon(Icons.arrow_forward_ios, size: 16),
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => SundayReminderPage()),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}

// Add this helper function at the top-level (outside any class):
DateTime _parseEventDate(String dateStr) {
  // Example: 'Aug 15, Fri' or 'Dec 16-24'
  // We'll use the first date in the range if it's a range
  final months = {
    'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
    'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
  };
  final parts = dateStr.split(',')[0].split('-')[0].trim().split(' ');
  if (parts.length < 2) return DateTime.now();
  final month = months[parts[0]] ?? 1;
  final day = int.tryParse(parts[1]) ?? 1;
  final now = DateTime.now();
  // Use this year, but if already passed, use next year
  var eventDate = DateTime(now.year, month, day);
  if (eventDate.isBefore(DateTime(now.year, now.month, now.day))) {
    eventDate = DateTime(now.year + 1, month, day);
  }
  return eventDate;
}

String _daysLeftText(DateTime eventDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
  final daysDiff = eventDay.difference(today).inDays;
  if (daysDiff > 0) {
    return "$daysDiff days";
  } else if (daysDiff == 0) {
    return "Today";
  } else {
    return "${-daysDiff} days ago";
  }
}

// Add these helper functions at the top-level (outside any class):
String _getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

String _formattedToday() {
  final now = DateTime.now();
  final weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  final months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  String weekday = weekdays[now.weekday - 1];
  String month = months[now.month - 1];
  return '$weekday, $month ${now.day}, ${now.year}';
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

// Update EventItem to accept daysLeftText and use normal font weight for title
class EventItem extends StatelessWidget {
  final String title;
  final String date;
  final String daysLeftText;

  const EventItem({required this.title, required this.date, required this.daysLeftText});

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
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        subtitle: Text('$date • $daysLeftText'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}

// Add the calendar page widget at the bottom of the file
class ChurchCalendarPage extends StatefulWidget {
  @override
  _ChurchCalendarPageState createState() => _ChurchCalendarPageState();
}

class _ChurchCalendarPageState extends State<ChurchCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late List<Reminder> _occasions;

  @override
  void initState() {
    super.initState();
    _generateOccasionsForCurrentYear();
  }

  void _generateOccasionsForCurrentYear() {
    final currentYear = DateTime.now().year;
    final easter = _calculateEasterSunday(currentYear);
    
    _occasions = [
      // Fixed date occasions
      Reminder(place: '', event: 'Solemnity of Mary, Mother of God', date: DateTime(currentYear, 1, 1), description: 'Mother of God Celebration'),
      Reminder(place: '', event: 'Epiphany of the Lord', date: DateTime(currentYear, 1, 7), description: 'Manifestation of Christ'),
      Reminder(place: '', event: 'Baptism of the Lord', date: DateTime(currentYear, 1, 12), description: 'Jesus\' Baptism'),
      Reminder(place: '', event: 'Presentation of the Lord', date: DateTime(currentYear, 2, 2), description: 'Candlemas Day'),
      Reminder(place: '', event: 'St. Joseph, Husband of Mary', date: DateTime(currentYear, 3, 19), description: 'Patron of the Universal Church'),
      Reminder(place: '', event: 'Sacred Heart of Jesus', date: DateTime(currentYear, 6, 13), description: 'Divine Love Celebration'),
      Reminder(place: '', event: 'Saints Peter and Paul', date: DateTime(currentYear, 6, 29), description: 'Apostles\' Feast'),
      Reminder(place: '', event: 'Assumption of Mary', date: DateTime(currentYear, 8, 15), description: 'Mary\'s Heavenly Assumption'),
      Reminder(place: '', event: 'All Saints\' Day', date: DateTime(currentYear, 11, 1), description: 'Celebration of All Saints'),
      Reminder(place: '', event: 'All Souls\' Day', date: DateTime(currentYear, 11, 2), description: 'Prayer for the Faithful Departed'),
      Reminder(place: '', event: 'Christ the King', date: DateTime(currentYear, 11, 23), description: 'Sovereignty of Christ'),
      Reminder(place: '', event: 'Immaculate Conception', date: DateTime(currentYear, 12, 8), description: 'Mary\'s Sinless Conception'),
      Reminder(place: '', event: 'Simbang Gabi (Dawn Masses)', date: DateTime(currentYear, 12, 16), description: 'Filipino Christmas Tradition'),
      Reminder(place: '', event: 'Christmas Day', date: DateTime(currentYear, 12, 25), description: 'Birth of Jesus Christ'),
      Reminder(place: '', event: 'New Year\'s Eve Thanksgiving Mass', date: DateTime(currentYear, 12, 31), description: 'Year-End Thanksgiving'),
      
      // Movable feasts (Easter-based)
      Reminder(place: '', event: 'Ash Wednesday', date: easter.subtract(Duration(days: 46)), description: 'Beginning of Lent'),
      Reminder(place: '', event: 'Palm Sunday', date: easter.subtract(Duration(days: 7)), description: 'Jesus\' Triumphal Entry'),
      Reminder(place: '', event: 'Holy Thursday', date: easter.subtract(Duration(days: 3)), description: 'Last Supper Celebration'),
      Reminder(place: '', event: 'Good Friday', date: easter.subtract(Duration(days: 2)), description: 'Crucifixion of Jesus'),
      Reminder(place: '', event: 'Black Saturday', date: easter.subtract(Duration(days: 1)), description: 'Jesus in the Tomb'),
      Reminder(place: '', event: 'Easter Sunday', date: easter, description: 'Resurrection of Jesus'),
      Reminder(place: '', event: 'Ascension of the Lord', date: easter.add(Duration(days: 39)), description: 'Jesus Ascends to Heaven'),
      Reminder(place: '', event: 'Pentecost Sunday', date: easter.add(Duration(days: 49)), description: 'Descent of the Holy Spirit'),
      Reminder(place: '', event: 'Holy Trinity Sunday', date: easter.add(Duration(days: 56)), description: 'Father, Son, and Holy Spirit'),
      Reminder(place: '', event: 'Corpus Christi', date: easter.add(Duration(days: 60)), description: 'Body and Blood of Christ'),
    ];
  }

  // Helper function to get description for each occasion
  String _getOccasionDescription(String eventName) {
    switch (eventName) {
      case 'Solemnity of Mary, Mother of God':
        return 'Mother of God Celebration';
      case 'Epiphany of the Lord':
        return 'Manifestation of Christ';
      case 'Baptism of the Lord':
        return 'Jesus\' Baptism';
      case 'Presentation of the Lord':
        return 'Candlemas Day';
      case 'St. Joseph, Husband of Mary':
        return 'Patron of the Universal Church';
      case 'Sacred Heart of Jesus':
        return 'Divine Love Celebration';
      case 'Saints Peter and Paul':
        return 'Apostles\' Feast';
      case 'Assumption of Mary':
        return 'Mary\'s Heavenly Assumption';
      case 'All Saints\' Day':
        return 'Celebration of All Saints';
      case 'All Souls\' Day':
        return 'Prayer for the Faithful Departed';
      case 'Christ the King':
        return 'Sovereignty of Christ';
      case 'Immaculate Conception':
        return 'Mary\'s Sinless Conception';
      case 'Simbang Gabi (Dawn Masses)':
        return 'Filipino Christmas Tradition';
      case 'Christmas Day':
        return 'Birth of Jesus Christ';
      case 'New Year\'s Eve Thanksgiving Mass':
        return 'Year-End Thanksgiving';
      case 'Ash Wednesday':
        return 'Beginning of Lent';
      case 'Palm Sunday':
        return 'Jesus\' Triumphal Entry';
      case 'Holy Thursday':
        return 'Last Supper Celebration';
      case 'Good Friday':
        return 'Crucifixion of Jesus';
      case 'Black Saturday':
        return 'Jesus in the Tomb';
      case 'Easter Sunday':
        return 'Resurrection of Jesus';
      case 'Ascension of the Lord':
        return 'Jesus Ascends to Heaven';
      case 'Pentecost Sunday':
        return 'Descent of the Holy Spirit';
      case 'Holy Trinity Sunday':
        return 'Father, Son, and Holy Spirit';
      case 'Corpus Christi':
        return 'Body and Blood of Christ';
      default:
        return 'Church Occasion';
    }
  }

  // In _ChurchCalendarPageState, add this helper to get all occasion dates for any year:
  List<DateTime> _getOccasionDatesForYear(int year) {
    return _occasions.map((reminder) {
      // If the event is fixed (e.g., Dec 25), just change the year
      return DateTime(year, reminder.date.month, reminder.date.day);
    }).toList();
  }

  // Add this helper function to compute Easter Sunday for any year
  DateTime _calculateEasterSunday(int year) {
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = (h + l - 7 * m + 114) ~/ 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  // Add this helper to get all movable feasts for a given year
  List<Reminder> _getMovableFeasts(int year) {
    final easter = _calculateEasterSunday(year);
    return [
      Reminder(place: '', event: 'Ash Wednesday', date: easter.subtract(Duration(days: 46))),
      Reminder(place: '', event: 'Palm Sunday', date: easter.subtract(Duration(days: 7))),
      Reminder(place: '', event: 'Holy Thursday', date: easter.subtract(Duration(days: 3))),
      Reminder(place: '', event: 'Good Friday', date: easter.subtract(Duration(days: 2))),
      Reminder(place: '', event: 'Black Saturday', date: easter.subtract(Duration(days: 1))),
      Reminder(place: '', event: 'Easter Sunday', date: easter),
      Reminder(place: '', event: 'Ascension of the Lord', date: easter.add(Duration(days: 39))),
      Reminder(place: '', event: 'Pentecost Sunday', date: easter.add(Duration(days: 49))),
      Reminder(place: '', event: 'Holy Trinity Sunday', date: easter.add(Duration(days: 56))),
      Reminder(place: '', event: 'Corpus Christi', date: easter.add(Duration(days: 60))),
      // Add more movable feasts here if needed
    ];
  }

  // Update _getEventsForDay to include both fixed and movable feasts for the selected year
  List<Reminder> _getEventsForDay(DateTime day) {
    // Fixed-date occasions (use month/day, any year)
    final fixed = _occasions.where((reminder) =>
      reminder.date.month == day.month &&
      reminder.date.day == day.day
    ).map((reminder) => Reminder(
      place: reminder.place,
      event: reminder.event,
      date: DateTime(day.year, reminder.date.month, reminder.date.day),
    ));
    // Movable feasts for the year
    final movable = _getMovableFeasts(day.year).where((reminder) =>
      reminder.date.month == day.month &&
      reminder.date.day == day.day
    );
    return [...fixed, ...movable];
  }

  // Helper to get days in a month
  List<int> _daysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return List.generate(lastDay, (i) => i + 1);
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
          'Church Calendar',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          // Removed calendar icon
        ],
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              eventLoader: (day) => _getEventsForDay(day),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black54),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black54),
                titleTextFormatter: (date, locale) => '', // Remove default title
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.black54),
                weekendStyle: TextStyle(color: Colors.black54),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFF1565C0).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF1565C0).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: Colors.black87),
                weekendTextStyle: TextStyle(color: Colors.black87),
                markersMaxCount: 1,
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 4,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
                headerTitleBuilder: (context, day) {
                  final months = [
                    'January', 'February', 'March', 'April', 'May', 'June',
                    'July', 'August', 'September', 'October', 'November', 'December'
                  ];
                  final years = List.generate(101, (i) => 2000 + i);
                  final days = _daysInMonth(day.year, day.month);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Custom month dropdown with closer label and arrow
                      DropdownButton<int>(
                        value: day.month,
                        underline: SizedBox(),
                        isDense: true,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                        items: List.generate(12, (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text(months[i], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        )),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _focusedDay = DateTime(_focusedDay.year, val, 1);
                            });
                          }
                        },
                      ),
                      SizedBox(width: 8),
                      DropdownButton<int>(
                        value: day.year,
                        underline: SizedBox(),
                        items: years.map((y) => DropdownMenuItem(
                          value: y,
                          child: Text(y.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        )).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _focusedDay = DateTime(val, _focusedDay.month, 1);
                            });
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          if (_selectedDay != null)
            _getEventsForDay(_selectedDay!).isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Icon(
                        Icons.calendar_today,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No events on ${_monthName(_selectedDay!.month)} ${_selectedDay!.day}, ${_selectedDay!.year}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                )
              : Column(
                  children: _getEventsForDay(_selectedDay!).map((reminder) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red[400],
                              child: Icon(Icons.church, color: Colors.white),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(reminder.event, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  SizedBox(height: 4),
                                  Text(_getOccasionDescription(reminder.event), style: TextStyle(color: Colors.black87)),
                                  SizedBox(height: 2),
                                  Text('Church Occasion', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                            Icon(Icons.repeat, color: Colors.orange[400]),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
          if (_selectedDay == null) ...[
            const SizedBox(height: 24),
            const Text(
              'Select a day to view events',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        ],
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

class _CustomMonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  const _CustomMonthYearPicker({required this.initialDate, required this.firstDate, required this.lastDate});

  @override
  State<_CustomMonthYearPicker> createState() => _CustomMonthYearPickerState();
}

class _CustomMonthYearPickerState extends State<_CustomMonthYearPicker> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;
  }

  List<int> _daysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return List.generate(lastDay, (i) => i + 1);
  }

  @override
  Widget build(BuildContext context) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final years = List.generate(widget.lastDate.year - widget.firstDate.year + 1, (i) => widget.firstDate.year + i);
    final days = _daysInMonth(selectedYear, selectedMonth);
    return AlertDialog(
      title: Row(
        children: [
          DropdownButton<int>(
            value: selectedMonth,
            items: List.generate(12, (i) => DropdownMenuItem(
              value: i + 1,
              child: Text(months[i]),
            )),
            onChanged: (val) {
              if (val != null) setState(() { selectedMonth = val; selectedDay = 1; });
            },
          ),
          SizedBox(width: 8),
          DropdownButton<int>(
            value: selectedYear,
            items: years.map((y) => DropdownMenuItem(value: y, child: Text(y.toString()))).toList(),
            onChanged: (val) {
              if (val != null) setState(() { selectedYear = val; selectedDay = 1; });
            },
          ),
        ],
      ),
      content: SizedBox(
        width: 300,
        height: 220,
        child: GridView.count(
          crossAxisCount: 7,
          children: days.map((d) => GestureDetector(
            onTap: () => setState(() { selectedDay = d; }),
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: selectedDay == d ? Color(0xFF1565C0) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  d.toString(),
                  style: TextStyle(
                    color: selectedDay == d ? Colors.white : Colors.black,
                    fontWeight: selectedDay == d ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          )).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, DateTime(selectedYear, selectedMonth, selectedDay));
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

String _formatTimeOfDay(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}