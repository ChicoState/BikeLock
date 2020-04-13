import 'dart:convert';

import 'package:flutter/material.dart';

import 'HTTPHelper.dart';
import 'auth.dart';

class LockInfo extends StatefulWidget {
  LockInfo({Key key, this.title, this.rackuuid, BaseAuth auth, void Function() onSignOut}) : super(key: key);
  final String title;
  final String rackuuid;

  @override
  _LockInfoState createState() => _LockInfoState();
}

class _LockInfoState extends State<LockInfo> {
  bool _lockState = false;
  int _numLocks = 1;
  int _curLock = 0;
  List<String> _stationLocks = ['0'];

  Future<bool> getLockState() async {
    //TODO error checking for failed attempts
    var http = HTTPHelper('/api/lock/', widget.rackuuid, _curLock, 0);
    final response = await http.get();
    Map<String, dynamic> result = json.decode(response.body);
    return result['state'] == 1;
  }

  setLockState(bool state) async {
    //TODO error checking for failed attempts
    var http = HTTPHelper('/api/lock/', widget.rackuuid, _curLock, state ? 1 : 0);
    final response = await http.post();
  }

  onButtonPress() async {
    var state = !(await getLockState());
    setState(() { _lockState = state; });
    setLockState(_lockState);
  }

  onMenuSelect(int newValueSelected) async {
    setState(() { this._curLock = newValueSelected; });
    var state = await getLockState();
    setState(() { _lockState = state ? true : false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              widget.rackuuid,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 50),

            // lock state text widget
            Text(
              'Your Bike is Locked up:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text('${_lockState.toString()}',
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(height: 50),

            // dropdown list for lock selection
            Text(
              'Lock ID:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton<String>(
              items: _stationLocks.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                  ),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                onMenuSelect(int.parse(newValueSelected));
              },
              value: _curLock.toString(),
            ),

          ],
        ),
      ),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(

          // lock button
          child: FloatingActionButton(
            onPressed: onButtonPress,
            child:
              _lockState ? Icon(Icons.lock) : Icon(Icons.lock_open),
            backgroundColor: _lockState ? Colors.green : Colors.red,
            splashColor: Colors.amber,
          ),

        ),
      ),
    );
  }
}