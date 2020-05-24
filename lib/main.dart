import 'package:cal/EventPage.dart';
import 'package:cal/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      home: Home(),
      routes: {
        Home.tag: (context) => Home(),
        Event.tag: (context) => Event(),
      },
    );
  }
}