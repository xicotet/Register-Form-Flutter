import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _loginName = '';
  String _password = '';
  bool _acceptConditions = false;
  String _gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Login'),
                onChanged: (value) {
                  setState(() {
                    _loginName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Accept conditions'),
                value: _acceptConditions,
                onChanged: (value) {
                  setState(() {
                    _acceptConditions = value ?? false;
                  });
                },
              ),
              RadioListTile(
                title: Text('Male'),
                value: 'male',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value as String;
                  });
                },
              ),
              RadioListTile(
                title: Text('Female'),
                value: 'female',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value as String;
                  });
                },
              ),
              RadioListTile(
                title: Text('No Binary'),
                value: 'no_binary',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value as String;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_loginName != null &&
                        _password != null &&
                        _acceptConditions == true &&
                        _gender != null) {
                      // Show welcome message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Welcome $_loginName'),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
