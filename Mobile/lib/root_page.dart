import 'package:flutter/material.dart';

import 'auth.dart';
import 'login_page.dart';
import 'rack_selection_screen.dart';


class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          title: 'Flutter Login',
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
      // Displaying racks
        return rack_selection_screen(
            onSignOut: () =>
                _updateAuthStatus(AuthStatus.notSignedIn
                ));
//        return new station_and_lock_selection_screen(
//            title: "Super Bike Lock",
//            auth: widget.auth,
//            onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn)
//        );
    }
  }
}