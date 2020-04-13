import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:superbikelock/lock_info.dart';
import 'HTTPHelper.dart';
import 'dart:developer' as developer;

class StationFinder extends StatefulWidget {
  StationFinder({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StationFinderState createState() => _StationFinderState();
}

class _StationFinderState extends State<StationFinder> {
  Future<dynamic> _stations;

  //final _biggerFont = const TextStyle(fontSize: 1);

  //TODO Add API docs to readme
  Future get_station_state() async {
    //TODO error checking for failed attempts
    var HTTP = HTTPHelper.method('/api/stations/');
    final response = await HTTP.get();
    return response;
  }

  @override
  void initState() {
    _stations = get_station_state();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      builder: (context, projectSnap) {
        // check if the future request is ready
        if (projectSnap.connectionState != ConnectionState.done) {
          if (projectSnap.connectionState == ConnectionState.waiting) {
            _stations = get_station_state();
          }
          return ListView();
        }

        // parse the future request, now that it's ready
        List<dynamic> stations = json.decode(projectSnap.data.body);
        developer.log(stations.length.toString());

        // create the ListView using the stations list
        return Scaffold(
          appBar: AppBar(title: Text(widget.title), centerTitle: true),
          body: ListView.separated(
            padding: const EdgeInsets.all(4),
            itemCount: stations.length,
            itemBuilder: (context, index) {
              developer.log(json.encode(stations[index]));
              return Container(
                height: 50,
                color: stations[index]['available']? Colors.green : Colors.red,
                child: ListTile(
                  title: Text(
                      '${stations[index]['ip']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        decoration: TextDecoration.none,
                      )
                  ),
                  onTap: () {
                    developer.log(stations[index]['ip']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LockInfo(
                          title:widget.title,
                          rackuuid:stations[index]["uuid"],
                          rackinfo:stations[index],
                      )),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        );
      },
      future: _stations,
    );
  }
}
