import 'package:flutter/material.dart';
import 'package:superbikelock/auth.dart';
import 'package:superbikelock/root_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Bike Lock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}