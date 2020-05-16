import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/lock_model.dart';
import '../model/rack_model.dart';
import 'lock_confirm_screen.dart';

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
}

class lock_selection_screenState extends State<lock_selection_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.rack.name),
          centerTitle: true
      ),
      body: ListView.builder(
        itemCount: widget.rack.listOfLocks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.rack.listOfLocks[index].name),
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


}


