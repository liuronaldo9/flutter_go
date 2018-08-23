import 'dart:async';
// import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostBlogPage extends StatefulWidget {
  @override
  _PostBlogPageState createState() => _PostBlogPageState();
}

class _PostBlogPageState extends State<PostBlogPage> {
  final formKey = GlobalKey<FormState>();
  String _title, _content;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        form.save();
        this.postBlog();
        Navigator.of(context).pushReplacementNamed('/blogs');
      });
    }
  }

  Future<dynamic> postBlog() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      'https://dev.gogox.co.nz/v1/core/testblog/blog',
      // headers: {'Content-Type': 'application/json'},
      body: {
        'title': _title,
        'content': _content,
        'userID': prefs.getString('userID'),
      },
    );
    //final responseJson = json.decode(response.body);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      return 'success';
    } else {
      return 'failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New BLog'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title cannot be empty.';
                  }
                },
                onSaved: (val) => _title = val,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.account_box),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'content cannot be empty.';
                  }
                },
                onSaved: (val) => _content = val,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Content',
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RaisedButton(
                child: Text(
                  'POST',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  _submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
