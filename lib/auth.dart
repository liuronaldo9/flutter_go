import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}
class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'phone': '',
    'password': '',
  };
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  
//  Widget _logoImage() {
//    return ClipOval(
//      child: Image.asset('assets/logo.png',
//      width: 200.0,
//      height: 200.0,),
//    );
//  }

  Widget _userNameTextField() {
    return TextFormField(
        autofocus: false,
        controller: _userController,
        decoration: InputDecoration(
             prefixIcon: Icon(Icons.account_box),
            hintText: 'Phone',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        onSaved: (String value) {
          setState(() {
            _formData['phone'] = value;
          });
        });
  }

  Widget _passwordTextField() {
    return TextFormField(
      autofocus: false,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
           prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onSaved: (String value) {
        setState(() {
          _formData['password'] = value;
        });
      },
    );
  }

  Future<Map<String, dynamic>> submitForm(
      String phone, String password) async {
    final Map<String, dynamic> authData = {
      'phone': _userController.text,
      'password': _passwordController.text,
      // 'returnSecureToken': true
    };
    final http.Response response = await http.post(
      'https://dev.gogox.co.nz/v1/core/testuser/login',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode != 200 ) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('用户名或密码错误'),
            content: Text("请输入正确的用户名或密码"),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    } else {
      // print(responseData['data']['accessToken']);
      final prefs = await SharedPreferences.getInstance();
      // prefs.setString('accessToken', responseData['data']['accessToken']);
      // prefs.setString('expiresAt', responseData['data']['expiresAt']);
      // prefs.setString('refreshToken', responseData['data']['refreshToken']);
      prefs.setString('userID', responseData['data']['id']);
      Navigator.of(context).pushReplacementNamed('/blogs');
      print(responseData);
      return null;
    }
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
        appBar: AppBar(
          title: Text('LOGIN'),
        ),
        body: Container(
          margin: EdgeInsets.all(25.0),
          // padding: EdgeInsets.all(5.0),
          child: Center(
            child: SingleChildScrollView(
                child: Container(
                    width: targetWidth,
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          // _logoImage(),
                          
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                'Phone',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          _userNameTextField(),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                'Password',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          _passwordTextField(),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(30.0),
                              shadowColor: Colors.lightBlueAccent.shade100,
                              elevation: 5.0,
                              child: MaterialButton(
                                minWidth: 200.0,
                                height: 42.0,
                                onPressed: () {
                                  submitForm(
                                    _formData['phone'],
                                    _formData['password'],
                                  );
                                },
                                color: Colors.blue,
                                child: Text('Log In',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(30.0),
                              shadowColor: Colors.lightBlueAccent.shade100,
                              elevation: 5.0,
                              child: MaterialButton(
                                minWidth: 200.0,
                                height: 42.0,
                                onPressed: () {
                                 Navigator.of(context).pushReplacementNamed('/signup');
                                },
                                color: Colors.blue,
                                child: Text('Signup',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          ),
        ));
  }
}