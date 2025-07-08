import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    final String location = data['location'] ?? 'Unknown';
    final String time = data['time'] ?? 'Time unavailable';
    final bool isDaytime = data['isDaytime'] ?? true;

    Color bgColor = isDaytime ? Colors.blue : Colors.indigo.shade900;
    IconData weatherIcon = isDaytime ? Icons.wb_sunny : Icons.nightlight_round;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 120.0, horizontal: 20.0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                    await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                        };
                      });
                    }
                  },
                  icon: const Icon(Icons.edit_location, color: Colors.white),
                  label: const Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 40.0),
                Icon(
                  weatherIcon,
                  size: 100,
                  color: Colors.yellowAccent,
                ),
                const SizedBox(height: 20.0),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
