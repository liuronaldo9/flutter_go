import 'dart:async';
import 'dart:convert';
import 'package:flutter_go/blog_post_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_go/blog_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBlogPage extends StatefulWidget {
  @override
  _CreateBlogPageState createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  List _blogs;

  Future<dynamic> getStore() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        'https://dev.gogox.co.nz/v1/core/testblog/blogs?userID=' +
            prefs.getString('uid'));
    final responseJson = json.decode(response.body);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      setState(() {
        _blogs = responseJson['data'];
      });
      return null;
    } else {
      return 'error';
    }
  }

  @override
  void initState() {
    super.initState();
    this.getStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      backgroundColor: Colors.grey,
      body: ListView.builder(
        itemCount: _blogs.length,
        itemBuilder: (context, index) {
          return BlogCard(
            title: _blogs[index]['title'],
            content: _blogs[index]['content'],
            user: _blogs[index]['user'],
            createdAt: _blogs[index]['createdAt'],
          );
        },
      ),
      floatingActionButton: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostBLogPage(),
            ),
          );
        },
      ),
    );
  }
}
