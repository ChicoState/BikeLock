import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:superbikelock/lock_selection_screen.dart';

// Create own file for Rack class
class Rack {
  final String rackName;
  final String rackDescription;
  final int totalLocks;
  final List<Lock> listOfLocks;

  Rack(this.rackName, this.rackDescription, this.totalLocks, this.listOfLocks);
}

class rack_selection_screen extends StatelessWidget {
//  final List<Rack> racks;

// TODO Populate with actual Rack/Stations and availability using HTTP Request

//  Sample Locks
//  List<Lock> sampleLockList;
  static Lock lock1 =
      Lock("Lock 1", "Lock 1 Description", "Belongs to rack 1", false);
  static Lock lock2 =
      Lock("Lock 2", "Lock 2 Description", "Belongs to rack 1", true);
  static List<Lock> sampleLockList = [lock1, lock2];

  static Lock lock3 =
      Lock("Lock 3", "Lock3 Description", "Belongs to rack 2", true);
  static Lock lock4 =
      Lock("Lock 4", "Lock4 Description", "Belongs to rack 2", false);
  static List<Lock> sampleLockList2 = [lock3, lock4];

  List<Rack> _AvailableRacks = [
    Rack("Rack 1", "This is Rack 1", sampleLockList.length, sampleLockList),
    Rack("Rack 2", "This is Rack 2", sampleLockList2.length, sampleLockList2),
  ];

  rack_selection_screen({Key key, void Function() onSignOut}) : super(key: key);

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
            title: Text(_AvailableRacks[index].rackName),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => lock_selection_screen(
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
}
