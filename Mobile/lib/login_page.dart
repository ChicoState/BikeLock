import 'package:flutter/material.dart';
import 'HTTPHelper.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}

  class _LoginPageState extends State<LoginPage>{

  final formKey = new GlobalKey<FormState>();

  String _email;
  String _username;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      print('Form is Valid. Email: $_email, Username:$_username password: $_password');
      return true;
    } else {
      print('Form is invalid. Email: $_email, password: $_password');
      return false;
    }
  }

  void validateAndSubmit() async {
    if(validateAndSave()){
        HTTPHelper createUserRequest = new HTTPHelper.empty();
        createUserRequest.createUser(_username, _password, _email);
      }
  }
  @override
    Widget build(BuildContext context){

      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Account Creation Demo'),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Email'),
                  validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                  onSaved: (value) => _email = value,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Username'),
                  validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
                  onSaved: (value) => _username = value,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                  onSaved: (value) => _password = value,
                ),
                new RaisedButton(
                  child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
                    onPressed: validateAndSubmit,
                )
              ]
            )
          )
        )
      );
  }


}

