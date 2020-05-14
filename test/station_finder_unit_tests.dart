import 'package:flutter_test/flutter_test.dart';
import 'package:superbikelock/login_page.dart';
import 'package:superbikelock/auth.dart';
import 'package:superbikelock/station_finder.dart';

void main() {

  test('title', () {

    // setup

    // run

    // verify
  });

  test('query station finder with station_finder_state, expect status 200 returned', () async {

    StationFinder station_finder = StationFinder();

    var response = await station_finder.createState().get_station_state();

    expect(response, '200');
  });

  test('query station finder with station_finder_state after initializing station, expect status 200 returned', () async {

    StationFinder station_finder = StationFinder();

    station_finder.createState().initState();
    Future<dynamic> response = station_finder.createState().get_station_state();

    expect(response, '200');
  });

}