import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyService {
  static final MyService _instance = MyService._internal();

  String _loginName = '';
  String _password = '';
  bool _acceptConditions = false;
  String _preferences = '';

  factory MyService() => _instance;

  MyService._internal() {}

  void setLoginName(String loginName) {
    _loginName = loginName;
  }

  String getLoginName() {
    return _loginName;
  }

  void setPassword(String password) {
    _password = password;
  }

  String getPassword() {
    return _password;
  }

  void setAcceptConditions(bool acceptConditions) {
    _acceptConditions = acceptConditions;
  }

  bool getAcceptConditions() {
    return _acceptConditions;
  }

  void setPreferences(String preference) {
    _preferences = preference;
  }

  String getPreferences() {
    return _preferences;
  }
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
  final myService = MyService();

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
                    myService.setLoginName(value);
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    myService.setPassword(value);
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Accept conditions'),
                value: myService.getAcceptConditions(),
                onChanged: (value) {
                  setState(() {
                    myService.setAcceptConditions(value ?? false);
                  });
                },
              ),
              Text(
                'Gender',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                title: Text('Male'),
                value: 'computers',
                groupValue: myService.getPreferences(),
                onChanged: (value) {
                  setState(() {
                    myService.setPreferences(value as String);
                  });
                },
              ),
              RadioListTile(
                title: Text('Female'),
                value: 'running',
                groupValue: myService.getPreferences(),
                onChanged: (value) {
                  setState(() {
                    myService.setPreferences(value as String);
                  });
                },
              ),
              RadioListTile(
                title: Text('Non-binary'),
                value: 'football',
                groupValue: myService.getPreferences(),
                onChanged: (value) {
                  setState(() {
                    myService.setPreferences(value as String);
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  child: Text('Register'),
                  onPressed: () {
                    if (myService.getLoginName() != null &&
                        myService.getPassword() != null &&
                        myService.getAcceptConditions() == true &&
                        myService.getPreferences() != null) {
                      // Show welcome message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Welcome ${myService.getLoginName()}'
                            'You\'ve accepted conditions '),
                      ));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You must accept conditions"),
                        ),
                      );
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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myService = MyService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                child: Column(children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(labelText: 'Login'),
                  onChanged: (value) {
                    setState(() {
                      myService.setLoginName(value);
                    });
                  } //NO PONGO COMAS AQUI
                  ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      myService.setPassword(value);
                    });
                  } //NO PONGO COMAS AQUI
                  ),
              Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                      child: Text('Send'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(),
                          ),
                        );
                      } //SIN COMA
                      ))
            ]))));
  }
}

class ChatService {
  static final ChatService _instance = ChatService._internal();
  List<String> _messages = [];

  factory ChatService() => _instance;

  ChatService._internal() {}

  void addMessage(String message, String username) {
    _messages.add("$username: $message");
  }

  List<String> getMessages() {
    return _messages;
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final myService = MyService();
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  List<String> _messages = [];
  final _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _chatService.getMessages().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_chatService.getMessages()[index]),
                    );
                  } //No pongo coma
                  )),
          TextFormField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Message')),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
                child: Text('Send'),
                onPressed: () {
                  setState(() {
                    _chatService.addMessage("${_textController.text}",
                        "${myService.getLoginName()} ");
                  });
                  _textController.clear();
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut //No pongo coma
                      );
                } //No pongo coma
                ), //No pongo coma
          )
        ]));
  }
}
