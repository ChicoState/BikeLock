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

            )
        ),
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

  String nameCity = "";
  var _AvailableLocks = ['Lock 1', 'Lock 2'];
  var _currentItemSelected = 'Lock 1';

  void lock_and_unlock() {

    //TODO Create drop down menu with list of the locks, hardcode for now
    //Variables for interacting with the locks, set them as you need to
    String UUID;
    int lock_ID;
    int state;

    //Creating HTTP Object
    var HTTP = HTTPHelper(UUID, lock_ID, state);

    //Attempting to post, this will fail until the DOMAIN string inside of it is set to real value
    HTTP.post();

    //This is doing a get request to a working endpoint online
    HTTP.get(false);

    //This will attempt to use the variables stored inside HTTP to do an actual get request from the server
    HTTP.get(true);

    setState(() {
      if(_counter == "false"){
        //TODO handle async issue so that I can print portion of json
        _counter = "true";
      }
      else{
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

          title: Text(widget.title), centerTitle: true
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Your Bike is Locked up:',),
          Text('$_counter',),
          DropdownButton<String>(
          items: _AvailableLocks.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),

          onChanged: (String newValueSelected) {
            // Your code to execute, when a menu item is selected from drop down
            _onDropDownItemSelected(newValueSelected);
          },

          value: _currentItemSelected,

        ),
        ],
      ),

    ),
    floatingActionButton: FloatingActionButton(
    onPressed: lock_and_unlock,
    tooltip: 'Increment',
    //TODO Alternating lock & unlock icon
    child: (_counter == "true") ? Icon(Icons.lock) : Icon(Icons.lock_open),
    backgroundColor: (_counter == "true") ? Colors.red : Colors.green,
    ),
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}


