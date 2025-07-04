import 'package:church_reminder/pages/Addreminder.dart';
import 'package:church_reminder/pages/Dashboard.dart';
import 'package:church_reminder/pages/ListItems.dart';
import 'package:church_reminder/pages/CustomReminder.dart';
import 'package:flutter/material.dart';

void main(){
 runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
 routes: {
  '/' : (context) => Dashboard(),
  '/add' : (context) => Addreminder(),
  '/occasions' : (context) => Listitems(),
  '/custom-reminders' : (context) => CustomReminder(),
 }
));
}
