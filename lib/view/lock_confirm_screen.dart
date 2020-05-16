import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:superbikelock/model/lock_model.dart';

import '../HTTPHelper.dart';

class lock_confirm_screen extends StatefulWidget {
  final Lock lock;

  lock_confirm_screen({Key key, @required this.lock}) : super(key: key);

  @override
  State<StatefulWidget> createState() => lock_confirm_screen_state();
}

class lock_confirm_screen_state extends State<lock_confirm_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lock.name), centerTitle: true),
      body: Center(
          child: Column(children: <Widget>[
        SizedBox(height: 50),
        Text(
          widget.lock.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 50),
        Text(
          widget.lock.description,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 50),

        Text(
          (widget.lock.available)
              ? "Your bike is Secured"
              : "This lock is unlocked",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 50),
        Container(
          height: 200.0,
          width: 200.0,
          child: FittedBox(
            child: FloatingActionButton(
              tooltip: 'Lock/Unlock',
              onPressed: () => lock_and_unlock(widget.lock),
              //Alternating Icon
              child: (widget.lock.available)
                  ? Icon(Icons.lock)
                  : Icon(Icons.lock_open),
              //Alternating Icon Color
              backgroundColor:
                  (widget.lock.available) ? Colors.green : Colors.red,
            ),
          ),
        ),
      ])),
    );
  }

  lock_and_unlock(Lock lock) async {
    developer.log("Attempting to lock/unlock");
    developer.log("Lock state: " + widget.lock.available.toString());
    developer.log("This lock state: " + widget.lock.name);

    //Locking or unlocking
    var HTTP =
    HTTPHelper('/api/lock/', widget.lock.rackUUID, lock.lockID,
        widget.lock.available ? 1 : 0);
    final response = await HTTP.post();

    setState(() {
      if (lock.available) {
        lock.available = false;
      } else {
        lock.available = (true);
      }
    });
  }


}
