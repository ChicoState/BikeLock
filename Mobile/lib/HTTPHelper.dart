import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';


//This is the API String I found on the github to interface with the server
final String STATION_API_CALL = '/api/station/';

//This is used as the URL Essentially ex: http://0.0.0.0:8000
final String DOMAIN = "www.Some_Domain.com";

//This class is meant to make all the HTTP requests cleaner
class HTTPHelper {

  String domain ;
  String UUID;
  int lock_ID;
  int state;

  //Constructor without Domain
  HTTPHelper(String UUID, int lock_ID, int state) {
    this.UUID = UUID;
    this.lock_ID = lock_ID;
    this.state = state;
  }

  //Constructor with Domain so that it can be tested if it needs to be altered
  HTTPHelper.withDomain(String domain, String UUID, int lock_ID, int state) {
    this.domain = domain;
    this.UUID = UUID;
    this.lock_ID = lock_ID;
    this.state = state;
  }


  //Post request using JSON
  post(){
    var frame = json.encode({
      'uuid': this.UUID,
      'lock_id': this.lock_ID,
      'state': this.state,
    });

    developer.log("POST CALLED... PRINTING FRAME:");
    developer.log(frame);
    http.post(domain, body: frame);
  }

  //TODO Agree upon a format for responses so I know how to parse

  //Http Get request
  // ---- Pass in TRUE in order to actually test get call locally, it will use the DOMAIN and STATION_API_CALL at the top
  // ---- Pass in false to test network connection and see what a working get request looks like
  get(bool test) async {
    developer.log("GET CALLED");


    if(test == true){
      String HttpString = DOMAIN + STATION_API_CALL;
      developer.log("GET STRING: " + HttpString);

      final response = await http.get(HttpString);
      developer.log("HTTP STATUS CODE: " + response.statusCode.toString());

      String responseString = json.decode(response.body).toString();
      developer.log(responseString);
    }

    //EXAMPLE OF WORKING GET RESPONSE
    else{
      final sampleresponse = await http.get('https://jsonplaceholder.typicode.com/albums/1');
      developer.log("HTTP STATUS CODE: " + sampleresponse.statusCode.toString());

      String sampleString = json.decode(sampleresponse.body).toString();
      developer.log(sampleString);
    }
  }
}