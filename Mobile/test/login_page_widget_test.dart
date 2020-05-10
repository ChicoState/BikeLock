import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superbikelock/HTTPHelper.dart';
import 'package:superbikelock/main.dart';

import 'package:superbikelock/login_page.dart';
import 'package:superbikelock/auth.dart';
import 'package:superbikelock/root_page.dart';


class MockHelper extends Mock implements HTTPHelper {}

class MockAuth extends Mock implements BaseAuth {}

void main() {

  Widget makeTestableWidget({Widget child, BaseAuth auth}) {
    return MaterialApp(
      home : new RootPage(
        auth : new Auth(),
      ),
    );
  }

  testWidgets('email and password are empty, sign in unsuccessful', (WidgetTester tester) async {

    MockAuth mockAuth = MockAuth();

    bool didSignIn = false;
    LoginPage page = LoginPage(onSignIn: () => didSignIn = true);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await tester.tap(find.byKey(Key('login')));

    verifyNever(mockAuth.signIn('', ''));
    expect(didSignIn, false);
  });

  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    //await tester.pumpWidget(MyApp());

    //await tester.pumpWidget(MyApp());
    await tester.pumpWidget(MyApp());

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    Finder loginButton = find.byKey(Key('login'));
    await tester.tap(find.byKey(Key('login')));


    // Create the Finders.
    //final titleFinder = find.text('T');

    final messageFinder = find.text('Form is Valid. Email: email, Username:null password: password');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    //expect(titleFinder, findsOneWidget);

    expect(messageFinder, findsNothing);
  });
}

