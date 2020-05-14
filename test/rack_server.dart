
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';

class RackServer {

  static const String method = 'http://';
  static const String serverDomain = 'rackServer:8000/';
  static const String loginEndpoint = 'rest-auth/login/';
  static const String logoutEndpoint = 'rest-auth/logout/';


  static Future<http.Response> get({ String endpoint, String body, Map<String,String> headers }) async {
  }

  static Future<http.Response> post({ String endpoint, String body, Map<String,String> headers}) async {
    developer.log("HTTP POST BODY: " + body);
    final response = await http.post(
        method + serverDomain + endpoint,
        headers: headers,
        body: body,
    );
    developer.log('HTTP POST STATUS CODE: ' + response.statusCode.toString());
    developer.log('HTTP POST RESPONSE: ' + response.body.toString());
    return response;
  }

  static Future<String> login(String username, String password) async {
    var headers = {"Content-Type": "application/json"};
    var frame = json.encode({
      'username': username,
      'password': password,
    });

    final response = await post( endpoint: loginEndpoint, headers: headers, body: frame );

    if (response.statusCode == 200) {
      return json.decode(response.body)['key'];
    }
    return null;
  }

  static Future<String> logout(String token) async {
    var headers = {"Content-Type": "application/json"};
    var body = json.encode({'key': token});

    final response = await post( endpoint: logoutEndpoint, headers: headers, body: body );

    if (response.statusCode == 200) return response.body;
    return null;
  }
}