import 'package:flutter_test/flutter_test.dart';
import 'package:superbikelock/login_page.dart';
import 'package:superbikelock/auth.dart';
import 'package:superbikelock/HTTPHelper.dart';


void main() {

  test('title', () {

    // setup

    // run

    // verify
  });

  test('empty email returns error string', () {

    var result = EmailVerifier.validate('');
    expect(result, 'Email can\'t be empty.');

  });

  test('non-empty email returns error string', () {

    var result = EmailVerifier.validate('email');
    expect(result, null);

  });

  test('empty password returns error string', () {

    var result = PasswordVerifier.validate('');
    expect(result, 'Password can\'t be empty.');

  });

  test('non-empty password returns error string', () {

    var result = PasswordVerifier.validate('password');
    expect(result, null);

  });

  test('login with valid email and password, return email', () async {

    Auth auth = Auth();
    String response = await auth.signIn('email', 'password');

    // response should be email because signIn() returns the email
    // if a status code of 200 is returned to it after the GET request
    expect(response, 'email');

  });

test('login with invalid email and password, return null', () async {

    Auth auth = Auth();
    String response = await auth.signIn('', '');

    // response will be null because 200 is not returned after the GET
    // due to invalid input
    expect(response, null);

});

  test('create user with valid email and password, return email', () async {

    Auth auth = Auth();
    String response = await auth.createUser('email', 'password');

    // response should be email because createUser() returns the email
    // if a status code of 200 is returned to it after the GET request
    expect(response, 'email');

  });

  test('create user with invalid email and password, return null', () async {

    Auth auth = Auth();
    String response = await auth.createUser('', '');

    // response will be null because 200 is not returned after the GET
    // due to invalid input
    expect(response, null);

  });


}

