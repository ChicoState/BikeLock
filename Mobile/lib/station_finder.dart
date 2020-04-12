import 'dart:convert';
import 'package:flutter/material.dart';
import 'HTTPHelper.dart';

class StationFinder extends StatefulWidget {
  StationFinder({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StationFinderState createState() => _StationFinderState();
}

class _StationFinderState extends State<StationFinder> {

  Map<String, dynamic> result;
  //final _biggerFont = const TextStyle(fontSize: 1);

  //TODO Add API docs to readme
  void get_station_state() async {
    //TODO error checking for failed attempts
    var HTTP = HTTPHelper('/api/station/', "", 0, 0);
    final response = await HTTP.get();
    result = json.decode(response.body);
  }

  List<String> entries = <String>['Station A', 'Station B', 'Station C', 'Station D'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
      padding: const EdgeInsets.all(4),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.blueGrey,
          child: Center(child: Text('${entries[index]}',
            style : TextStyle(
              color: Colors.black,
              fontSize: 30,
              decoration: TextDecoration.none,
            ))),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }



}