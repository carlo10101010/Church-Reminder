import 'package:flutter/material.dart';
import 'WorldTime.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi'),
    WorldTime(url: 'America/Chicago', location: 'Chicago'),
    WorldTime(url: 'America/New_York', location: 'New York'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul'),
    WorldTime(url: 'Asia/Manila', location: 'Manila'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo'),
    WorldTime(url: 'Australia/Sydney', location: 'Sydney'),
    WorldTime(url: 'Asia/Dubai', location: 'Dubai'),
    WorldTime(url: 'Asia/Singapore', location: 'Singapore'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow'),
    WorldTime(url: 'Asia/Bangkok', location: 'Bangkok'),
    WorldTime(url: 'America/Los_Angeles', location: 'Los Angeles'),
    WorldTime(url: 'Pacific/Honolulu', location: 'Honolulu'),
    WorldTime(url: 'Europe/Paris', location: 'Paris'),
    WorldTime(url: 'Asia/Kolkata', location: 'Mumbai'),
    WorldTime(url: 'America/Sao_Paulo', location: 'São Paulo'),
    WorldTime(url: 'Africa/Johannesburg', location: 'Johannesburg'),
  ];

  void updateTime(int index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    // navigate to home and pass data
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Choose a Location'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () => updateTime(index),
                title: Text(locations[index].location),
                leading: const Icon(Icons.public),
              ),
            ),
          );
        },
      ),
    );
  }
}