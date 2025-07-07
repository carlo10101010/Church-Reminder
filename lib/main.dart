import 'package:church_reminder/pages/Addreminder.dart';
import 'package:church_reminder/pages/Dashboard.dart';
import 'package:church_reminder/pages/Itemcart.dart';
import 'package:church_reminder/pages/ListItems.dart';
import 'package:church_reminder/World_Time/Home.dart';
import 'package:church_reminder/World_Time/Loading.dart';
import 'package:church_reminder/World_Time/Choose_Location.dart';
import 'package:flutter/material.dart';


void main() {
 runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
   '/dashboard': (context) => Dashboard(),
   '/add' : (context) => Addreminder(),
   '/loading' : (context) => Loading(),
   '/' : (context) => Home(),
   '/location' : (context) => ChooseLocation()

  },
 ));
}
