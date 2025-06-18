import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        backgroundColor: Colors.cyanAccent[100],
      appBar: AppBar(
        title: Text('Church Reminder'),
        backgroundColor: Colors.blue[400],
      ),
       body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Centers the items vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers the items horizontally
            children: [
              Text('Carlo', style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
              ),
              Text('P.', style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
              ),
              Text('Mendoza', style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
              ),],
      ),
    )
  )));
}

