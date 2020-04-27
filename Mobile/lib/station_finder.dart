import 'dart:convert';
import 'package:flutter/material.dart';
import 'HTTPHelper.dart';
import 'dart:developer' as developer;

class StationFinder extends StatefulWidget {
  StationFinder({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StationFinderState createState() => _StationFinderState();
}

class _StationFinderState extends State<StationFinder> {

  Map<String, dynamic> result;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  //TODO Add API docs to readme
  void get_station_state() async {
    //TODO error checking for failed attempts
    var HTTP = HTTPHelper('/api/station/', "", 0, 0);
    final response = await HTTP.get();
    result = json.decode(response.body);
  }

    final List<String> entries = <String>[];
    final List<int> colorCodes = <int>[600, 500, 100];

    void get_station_uuids(Map<String, dynamic> res) {
      for (var i = 0; i < res.length; i++) {
        entries.add(result['UUID']);
      }
    }

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Entry ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

}