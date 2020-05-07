import 'package:flutter_test/flutter_test.dart';
import 'package:superbikelock/login_page.dart';


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
}

