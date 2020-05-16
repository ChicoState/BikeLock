import 'dart:async';

import 'package:superbikelock/HTTPHelper.dart';


abstract class BaseAuth {

  Future<String> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut(String email, String password);
}

class Auth implements BaseAuth {
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  HTTPHelper HTTPFunctions = HTTPHelper.empty();
  String userID;
  Future<String> signIn(String email, String password) async {
    String user = await HTTPFunctions.signInUser(email, password);
    userID = user;
    return userID;
  }

  Future<String> createUser(String email, String password) async {
    String user = await HTTPFunctions.createUser(email, password);
    userID = user;
    return userID;
  }

  Future<String> currentUser() async {
    return userID != null ? userID : null;
  }

  Future<bool> signOut(String email, String password) async {
    return await HTTPFunctions.signOutUser(email, password);
  }


}