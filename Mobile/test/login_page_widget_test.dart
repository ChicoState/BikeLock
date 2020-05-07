import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superbikelock/login_page.dart';
import 'package:superbikelock/auth.dart';
import 'package:superbikelock/root_page.dart';

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

}
