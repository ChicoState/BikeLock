import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:superbikelock/HTTPHelper.dart';
import 'package:superbikelock/model/rack_model.dart';
import 'package:superbikelock/view/lock_selection_screen.dart';

class rack_selection_screen extends StatefulWidget {
//  final List<Rack> racks;

//  Sample Locks
//  List<Lock> sampleLockList;
//  static Lock lock1 = Lock(
//      "Lock 1", "Lock 1 Description", "Belongs to rack 1", false);
//  static Lock lock2 = Lock(
//      "Lock 2", "Lock 2 Description", "Belongs to rack 1", true);
//  static List<Lock> sampleLockList = [lock1, lock2];
//
//  static Lock lock3 = Lock(
//      "Lock 3", "Lock3 Description", "Belongs to rack 2", true);
//  static Lock lock4 = Lock(
//      "Lock 4", "Lock4 Description", "Belongs to rack 2", false);
//  static List<Lock> sampleLockList2 = [lock3, lock4];
//
//  List<Rack> _AvailableRacks = [
//    Rack("Rack 1", "This is Rack 1", sampleLockList.length, sampleLockList),
//    Rack("Rack 2", "This is Rack 2", sampleLockList2.length, sampleLockList2),
//  ];

  // TODO Populate with actual Rack/Stations and availability using HTTP Request


  rack_selection_screen({Key key, void Function() onSignOut}) : super(key: key);

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Rack Selection Screen'),
//      ),
//      body: ListView.builder(
//        itemCount: _AvailableRacks.length,
//        itemBuilder: (context, index) {
//          return ListTile(
//            title: Text(_AvailableRacks[index].rackName),
//            onTap: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => lock_selection_screen(
//                      rack: _AvailableRacks[index],
//                    ),
//                  )
//              );
//            },
//          );
//        },
//      ),
//    );
//  }

  @override
  State<StatefulWidget> createState() => rack_selection_screen_state();
}

class rack_selection_screen_state extends State<rack_selection_screen> {

  List<Rack> _AvailableRacks = new List();

  get_active_stations() async {
    developer.log("Limga");
    HTTPHelper stations = HTTPHelper(
        "pointless String", "another string", 0, 0);

    Future<List> activeStations = stations.getActiveStations();
    return activeStations;
  }

  @override
  Future<void> initState() {
    get_active_stations().then((stations) {
      setState(() {
        developer.log("Limga");

        _AvailableRacks = stations;
      });
    });
//    get_active_stations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rack Selection Screen'),
      ),
      body: ListView.builder(
        itemCount: _AvailableRacks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_AvailableRacks[index].name),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        lock_selection_screen(
                          rack: _AvailableRacks[index],
                        ),
                  )
              );
            },
          );
        },
      ),
    );
  }

//  get_active_stations() async {
//    HTTPHelper stations = HTTPHelper("pointless String", "another string", 0, 0 );
//
//    Future<List> activeStations = stations.getActiveStations();
//    widget._AvailableRacks =  activeStations as List<Rack>;
//  }

}
