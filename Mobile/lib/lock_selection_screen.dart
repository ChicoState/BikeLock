import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'lock_confirm_screen.dart';
import 'model/lock_model.dart';
import 'model/rack_model.dart';

class lock_selection_screen extends StatefulWidget {
//  final List<Lock> locks;
  Rack rack;
  Lock lock;
  // TODO Populate with actual Locks and availability using HTTP Request
//  var _AvailableLocks = rack.listOfLocks;

  lock_selection_screen({Key key, @required this.rack}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      lock_selection_screenState();

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(rack.rackName),
//      ),
//      body: ListView.builder(
//        itemCount: rack.totalLocks,
//        itemBuilder: (context, index) {
//          return ListTile(
//            title: new Text(rack.listOfLocks[index].lockName),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) =>
//                      lock_selection_screenState(lock: rack.listOfLocks[index]),
//                ),
//              );
//            },
//          );
//        },
//      ),
//    );
//  }


}

class lock_selection_screenState extends State<lock_selection_screen> {
//  var lock;


//  final Lock = widget.lock;
//  lock_selection_screen({Key key, @required this.lock}) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.rack.rackName),
          centerTitle: true
      ),
      body: ListView.builder(
        itemCount: widget.rack.listOfLocks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.rack.listOfLocks[index].lockName),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        lock_confirm_screen(
                          lock: widget.rack.listOfLocks[index],
                        ),
                  )
              );
            },
          );
        },
      ),

    );
  }
//
//  lock_and_unlock(Lock lock) {
//    developer.log("Attempting to lock/unlock");
//    developer.log("Lock state: " + lock.available.toString());
//    developer.log("This lock state: " + lock.lockName);
//
//    setState(() {
//      if (lock.available) {
//        lock.available = false;
//      }
//      else {
//        lock.available = (true);
//      }
//    });
//
//  }

}

//class LockDetailScreen extends StatelessWidget {
//  final Lock lock;
//
//  LockDetailScreen({Key key, @required this.lock}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//          title: Text(lock.lockName),
//          centerTitle: true
//      ),
//      body: Center(
//          child: Column(
//              children: [
//                SizedBox(height: 50),
//                Text(lock.lockName,
//                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//                SizedBox(height: 50),
//                Text(lock.lockDescription,
//                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//                SizedBox(height: 50),
//                Text(lock.belongsToRack,
//                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//                SizedBox(height: 50),
//                Text(lock.available.toString(),
//                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//                SizedBox(height: 50),
//              ]
//          )
//      ),
//
//      floatingActionButton: Container(
//        height: 100.0,
//        width: 100.0,
//        child: FittedBox(
//          child: FloatingActionButton(
//            //TODO Make button only work when pressed, and not on loading of screen
//            tooltip: 'Lock/Unlock',
//            onPressed: () => lock_and_unlock(lock),
//            //Alternating Icon
//            child: (lock.available)
//                ? Icon(Icons.lock)
//                : Icon(Icons.lock_open),
//            //Alternating Icon Color
//            backgroundColor: (lock.available) ? Colors.green : Colors.red,
//          ),
//        ),
//      ),
//    );
//  }
//
//  lock_and_unlock(Lock lock) {
//    developer.log("Attempting to lock/unlock");
//    developer.log("Lock state: " + lock.available.toString());
//    developer.log("This lock state: " + lock.lockName);
//
//    if (lock.available) {
//      lock.available = false;
//    }
//    else {
//      lock.available = (true);
//    }
//  }
//}

