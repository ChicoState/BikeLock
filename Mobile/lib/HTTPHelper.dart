import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:superbikelock/model/rack_model.dart';

import 'model/lock_model.dart';

//This is the API String I found on the github to interface with the server
const String STATION_API_CALL = "/api/lock/";

//This is used as the URL Essentially ex: http://0.0.0.0:8000
const String DOMAIN = "rackServer:8000";

const String METHOD = "http://";

const String ACCOUNT_CREATION_URL = "/api/create-user/";

const String WEBSERVER = "0.0.0.0:8000";

const String SIGNIN_URL = "/rest-auth/login/";

const String SIGNOUT_URL = "/rest-auth/logout/";

const String GET_STATIONS = "/api/stations/";

//This class is meant to make all the HTTP requests cleaner
class HTTPHelper {
  //TODO make all these initialized in each function instead of entire class having to use them everytime
  String api_method;
  String UUID;
  int lock_ID;
  int state;

  //Constructor without Domain
  HTTPHelper(String method, String UUID, int lock_ID, int state) {
    this.api_method = method;
    this.UUID = UUID;
    this.lock_ID = lock_ID;
    this.state = state;
  }

  HTTPHelper.method(String method) {
    this.api_method = method;
    this.UUID = "";
    this.lock_ID = 0;
    this.state = 0;
  }

  HTTPHelper.empty();

  //Post request using JSON
  Future<http.Response> post() async {
    var frame = json.encode({
      'uuid': this.UUID,
      'lock_id': this.lock_ID,
      'state': this.state,
    });
    developer.log("HTTP POST FRAME: " + frame);

    final http.Response response = await http.post(
        METHOD + DOMAIN + this.api_method, body: frame);
    developer.log('HTTP POST STATUS CODE: ' + response.statusCode.toString());
    developer.log('HTTP POST RESPONSE: ' + response.body.toString());
    return response;
  }

  //Http Get request
  Future<http.Response> get() async {
    var frame = {
      'uuid': this.UUID,
      'lock_id': this.lock_ID.toString(),
      'state': this.state.toString(),
    };
    final uri = Uri.http(DOMAIN, this.api_method, frame);
    developer.log("HTTP GET REQUEST: " + uri.toString());

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final http.Response response = await http.get(uri, headers: headers);
    developer.log('HTTP GET STATUS CODE: ' + response.statusCode.toString());
    developer.log('HTTP GET RESPONSE: ' + response.body.toString());
    return response;
  }

  Future<String> createUser(String email, String password) async {
    //Creating data to be sent.
    var frame = json.encode({
      'password': password,
      'email': email,
    });
    String url = METHOD + WEBSERVER + ACCOUNT_CREATION_URL;
    developer.log(url);
    developer.log(frame);

    ///    Post request to actually create account
    http.Response response = await http.post(
        METHOD + WEBSERVER + ACCOUNT_CREATION_URL, body: frame);

    developer.log('HTTP GET STATUS CODE: ' + response.statusCode.toString());
    developer.log('HTTP GET RESPONSE: ' + response.body.toString());
//
    //TODO uncomment to make useful
//    return "StringBeans";
    if(response.statusCode == 200){
      return email;
    }
    else{
      return null;
    }
  }

  Future<String> signInUser(String email, String password) async {
    //Creating data to be sent.
    var frame = json.encode({
      'password': password,
      'email': email,
    });
    String url = METHOD + WEBSERVER + SIGNIN_URL;
    developer.log(url);
    developer.log(frame);


//        return "StringBeans";

    ///    Post request to actually create account
    http.Response response = await http.post(
        url, body: frame);

    developer.log('HTTP GET STATUS CODE: ' + response.statusCode.toString());
    developer.log('HTTP GET RESPONSE: ' + response.body.toString());

    //TODO uncomment to make useful

    if(response.statusCode == 200){
      return email;
    }
    else{
      return null;
    }
  }

  Future<bool> signOutUser(String email, String password) async {
    //Creating data to be sent.
    var frame = json.encode({
      'password': password,
      'email': email,
    });
    String url = METHOD + WEBSERVER + SIGNOUT_URL;
    developer.log(url);
    developer.log(frame);

    ///    Post request to actually create account

    http.Response response = await http.post(
        url, body: frame);

    developer.log('HTTP GET STATUS CODE: ' + response.statusCode.toString());
    developer.log('HTTP GET RESPONSE: ' + response.body.toString());

    //TODO uncomment to make useful
//    return "StringBeans";
    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

  Future<List> getActiveStations() async {
    //Creating Request to be sent.
    String url = METHOD + WEBSERVER + GET_STATIONS;

    developer.log(url);


    Lock lock1 = Lock(0, "Lock 1", "Lock 1 Description",
        "b80e7c2a-91d1-4718-a1f3-2e2c7d260646", false);
    Lock lock2 = Lock(1, "Lock 2", "Lock 2 Description",
        "b80e7c2a-91d1-4718-a1f3-2e2c7d260646", true);
    Lock lock3 = Lock(2, "Lock 3", "Lock3 Description",
        "095a6367-0fc7-4a91-995f-a7268c6e76cf", true);
    Lock lock4 = Lock(3, "Lock 4", "Lock4 Description",
        "095a6367-0fc7-4a91-995f-a7268c6e76cf", false);
    List<Lock> sampleLockList = [lock1, lock2];
    List<Lock> sampleLockList2 = [lock3, lock4];

    List<Rack> _AvailableRacks = [
      Rack("uuid1 ", "Online Rack", "This is Rack 1", sampleLockList.length,
          sampleLockList),
      Rack("095a6367-0fc7-4a91-995f-a7268c6e76cf", "Rack 2", "This is Rack 2",
          sampleLockList2.length, sampleLockList2),

    ];

    /// Comment this out to get it to actually make request for servers
    return _AvailableRacks;


//    http.Response response = await http.get(url);
//
//    developer.log('HTTP GET STATUS CODE: ' + response.statusCode.toString());
//    developer.log('HTTP GET RESPONSE: ' + response.body.toString());
//
//    if(response.statusCode == 200){
//      return response;
//    }
//    else{
//      return null;
//    }
  }
}