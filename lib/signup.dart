import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  final Map<String, dynamic> _formData = {
    'name': '',
    'phone': '',
    'password': '',
  };
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();

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
        controller: _nameController,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.ac_unit),
            hintText: 'Name',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        onSaved: (String value) {
          setState(() {
            _formData['name'] = value;
          });
        });
  }

  Widget _userPhoneTextField() {
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
      String name, String phone, String password) async {
    final Map<String, dynamic> authData = {
      'name': _nameController.text,
      'phone': _userController.text,
      'password': _passwordController.text,
      // 'returnSecureToken': true
    };
    final http.Response response = await http.post(
      'https://dev.gogox.co.nz/v1/core/testuser/user',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode != 200) {
      print(authData);
    } else {
      // print(responseData['data']['accessToken']);
      // final prefs = await SharedPreferences.getInstance();
      // // prefs.setString('accessToken', responseData['data']['accessToken']);
      // // prefs.setString('expiresAt', responseData['data']['expiresAt']);
      // // prefs.setString('refreshToken', responseData['data']['refreshToken']);
      // prefs.setString('userID', responseData['data']['id']);
      // // Navigator.of(context).pushReplacementNamed('/store');
      // print(responseData);
      return null;
    }
     Navigator.of(context).pushReplacementNamed('/');
    print(responseData);
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
        appBar: AppBar(
          title: Text('SIGNUP'),
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
                          _userPhoneTextField(),
                          SizedBox(
                            height: 30.0,
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
                                    _formData['name'],
                                    _formData['phone'],
                                    _formData['password'],
                                  );
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
