import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.cyanAccent[100],
      appBar: AppBar(
        title: const Text(
          'Church Reminder',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: const EdgeInsets.all(25),
            child: Row(
              children: [
                const Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'Carlo',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Age:',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    '210 years old',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Row(
              children: [
                const Text(
                  'Gender:',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'Male',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  ));
}
