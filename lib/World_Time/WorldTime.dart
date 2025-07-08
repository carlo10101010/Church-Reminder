import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;   // location name for UI
  String time = '';  // time in that location
  String url;        // timeZone string for API
  bool isDaytime = true;

  WorldTime({
    required this.location,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      final uri = Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url');
      print('[WorldTime] Fetching from: $uri');

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to load time');
      }

      final data = jsonDecode(response.body);
      String dateTime = data['dateTime']; // example: "2025-07-07T22:22:58.0917013"
      DateTime now = DateTime.parse(dateTime);

      isDaytime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now);

      print('[WorldTime] Computed time: $time');
    } catch (e) {
      print('[WorldTime] Error: $e');
      time = 'Could not get time';
    }
  }
}
