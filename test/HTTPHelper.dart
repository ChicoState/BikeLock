import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;

//This is the API String I found on the github to interface with the server
final String STATION_API_CALL = "/api/lock/";

//This is used as the URL Essentially ex: http://0.0.0.0:8000
final String DOMAIN = "rackServer:8000";

final String METHOD = "http://";

final String ACCOUNT_CREATION_URL = "/api/create-user/";

final String WEBSERVER = "0.0.0.0:8000";

final String SIGNIN_URL = "/rest-auth/login/";

final String SIGNOUT_URL = "/rest-auth/logout/";

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

    ///    Post request to actually create account
    http.Response response = await http.post(
        url, body: frame);

    developer.log('HTTP GET STATUS CODE: ' + response.statusCode.toString());
    developer.log('HTTP GET RESPONSE: ' + response.body.toString());

    //TODO uncomment to make useful
//    return "StringBeans";
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
}