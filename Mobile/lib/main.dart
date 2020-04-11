import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'HTTPHelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Bike Lock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Super Bike Lock'),
      home: Scaffold(
        body: Center(
            child: new Center(
          child: MyHomePage(title: 'Super Bike Lock'),
        )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "false";

  var _AvailableStations = ['Station 1', 'Station 2'];
  var _currentStation = 'Station 1';

  var _AvailableLocks = ['Lock 1', 'Lock 2'];
  var _currentLock = 'Lock 1';

  String get_cur_uuid() {
    if (_currentStation == 'Station 1') {
      return "b80e7c2a-91d1-4718-a1f3-2e2c7d260646";
    } else if (_currentStation == 'Station 2') {
      return "095a6367-0fc7-4a91-995f-a7268c6e76cf";
    }
    return "UNKOWN-LOCK";
  }

  int get_cur_lock() {
    if (_currentLock == 'Lock 1') {
      return 0;
    } else if (_currentLock == 'Lock 2') {
      return 1;
    }
    return -1;
  }


  //TODO Add API docs to readme
  Future<bool> get_lock_state() async {
    //TODO error checking for failed attempts
    var HTTP = HTTPHelper('/api/lock/', get_cur_uuid(), get_cur_lock(), 0);
    final response = await HTTP.get();
    Map<String, dynamic> result = json.decode(response.body);
    return result['state'] == 1;
  }

  set_lock_state(bool state) async {
    //TODO error checking for failed attempts
    var HTTP =
        HTTPHelper('/api/lock/', get_cur_uuid(), get_cur_lock(), state ? 1 : 0);
    final response = await HTTP.post();
  }

  lock_and_unlock() async {
    var state = await get_lock_state();
    set_lock_state(!state);

    setState(() {
      //TODO handle async issue so that I can print portion of json
      if (!state) {
        _counter = "true";
      } else {
        _counter = "false";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.

          title: Text(widget.title),
          centerTitle: true),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Bike is Locked up:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text('$_counter',
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(height: 50),
            Text(
              'Station ID:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton<String>(
              items: _AvailableStations.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                // Your code to execute, when a menu item is selected from drop down
                _onStationItemSelected(newValueSelected);
              },
              value: _currentStation,
            ),
            SizedBox(height: 50),
            Text(
              'Lock ID:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton<String>(
              items: _AvailableLocks.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                  ),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                // Your code to execute, when a menu item is selected from drop down
                _onLockItemSelected(newValueSelected);
              },
              value: _currentLock,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: lock_and_unlock,
            tooltip: 'Increment',
            //Alternating Icon
            child:
                (_counter == "true") ? Icon(Icons.lock) : Icon(Icons.lock_open),
            //Alternating Icon Color
            backgroundColor: (_counter == "true") ? Colors.green : Colors.red,
            splashColor: Colors.amber,
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onStationItemSelected(String newValueSelected) async {
    setState(() {
      this._currentStation = newValueSelected;
    });
    var state = await get_lock_state();
    setState(() {
      _counter = state ? "true" : "false";
    });
  }

  void _onLockItemSelected(String newValueSelected) async {
    setState(() {
      this._currentLock = newValueSelected;
    });
    var state = await get_lock_state();
    setState(() {
      _counter = state ? "true" : "false";
    });
  }
}
