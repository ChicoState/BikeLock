import 'dart:async';

import 'package:superbikelock/HTTPHelper.dart';


abstract class BaseAuth {

  Future<String> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut();
}

class Auth implements BaseAuth {
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  HTTPHelper HTTPFunctions = HTTPHelper.empty();
  String userID;
  Future<String> signIn(String email, String password) async {
//    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    //TODO update with sign in funcionality instead of creating account everytime
    String user = await HTTPFunctions.createUser(email, password);
    userID = user;
    return userID;
  }

  Future<String> createUser(String email, String password) async {
//    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    String user = await HTTPFunctions.createUser(email, password);
    userID = user;
    return userID;
  }

  Future<String> currentUser() async {
//    FirebaseUser user = await _firebaseAuth.currentUser();
    return userID != null ? userID : null;
  }

  Future<void> signOut() async {
//    return _firebaseAuth.signOut();
  }


}