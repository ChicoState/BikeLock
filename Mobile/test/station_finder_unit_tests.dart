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

  test('enter email and password but no user, return null', () async {


    StationFinder station_finder = StationFinder();

    String response = await station_finder.createState().get_station_state();

    // TODO Comment This
    expect(response, null);

  });

  test('enter email and password but no user, return null', () async {


    StationFinder station_finder = StationFinder();

    station_finder.createState().initState();
    String response = await station_finder.createState().get_station_state();

    // TODO Comment This
    expect(response, null);

  });

}