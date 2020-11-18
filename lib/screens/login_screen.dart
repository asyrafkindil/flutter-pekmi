import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(child: Container()),
                Text(
                  'SILAT CLUB',
                  style: TextStyle(
                    fontFamily: 'Monospace',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (val) => val.isEmpty
                              ? 'Please enter your email address'
                              : null,
                          onSaved: (val) => _email = val,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (val) =>
                              val.isEmpty ? 'Please enter your password' : null,
                          onSaved: (val) => _email = val,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              onPressed: () {},
                              child: Text('Register?'),
                            ),
                            if (_isLoading)
                              CircularProgressIndicator()
                            else
                              RaisedButton(
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .loginDummy();
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
