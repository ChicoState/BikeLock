import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:superbikelock/auth.dart';
import 'package:superbikelock/root_page.dart';
import 'HTTPHelper.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Bike Lock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

///Uncomment this and comment out the other home tag to view login/account creation.
      home: new RootPage(auth: new Auth()),
    ///Comment from here to other comment tag
//      home: Scaffold(
//        body: Center(
//            child: new Center(
//          child: MyHomePage(title: 'Super Bike Lock'),
//        )),
//      ),
      ///Comment Tag

    );
  }
}