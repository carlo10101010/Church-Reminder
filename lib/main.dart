import 'package:flutter/material.dart';
import 'World_Time/ChooseLocation.dart';
import 'World_Time/Home.dart';
import 'World_Time/Loading.dart';


void main() => runApp(MaterialApp(
 debugShowCheckedModeBanner: false,
 initialRoute: '/',
 routes: {
  '/': (context) => Loading(),
  '/home': (context) => Home(),
  '/location': (context) => ChooseLocation(),
 },
));

