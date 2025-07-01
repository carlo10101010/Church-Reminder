import 'package:church_reminder/pages/Addreminder.dart';
import 'package:church_reminder/pages/Dashboard.dart';
import 'package:church_reminder/pages/ListItems.dart';
import 'package:flutter/material.dart';

void main(){
 runApp(MaterialApp(
 routes: {
  '/' : (context) => Listitems(),
  '/add' : (context) => Addreminder()
 }
));
}
