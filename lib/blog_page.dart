import 'dart:async';
import 'dart:convert';
import 'package:flutter_go/blog_post_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_go/blog_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List _blogs;

  Future<dynamic> getStore() async {
    print(1);
    final prefs = await SharedPreferences.getInstance();

    print(2);
    final response = await http.get(
        'https://dev.gogox.co.nz/v1/core/testblog/blogs?userID=' +
            prefs.getString('userID'));

    print(3);
    final responseJson = json.decode(response.body);
    final int statusCode = response.statusCode;

    print(4);
    if (statusCode == 200) {
      print(responseJson['data']);
      setState(() {
        _blogs = responseJson['data'];
      });
      return null;
    } else {
      print("i am error1");
      return 'error';
    }
  }

  @override
  void initState() {
    super.initState();
    print("i am error2");
    this.getStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      backgroundColor: Colors.grey,
      // body: ListView.builder(
      //   itemCount: _blogs.length,
      //   itemBuilder: (context, index) {
      //     return Container(
      //       child: Column(
      //         children: <Widget>[
      //           Text(_blogs[index]['title']),
      //           Text(_blogs[index]['content']),
      //           Text(_blogs[index]['user']),
      //           Text(_blogs[index]['createdAt']),
      //         ],
      //       ),
      //     );
      //   },
      // ),
      body: ListView.builder(
        itemCount: _blogs == null ? 0 : _blogs.length,
        itemBuilder: (BuildContext context, int index) {
          //  return new Column(
          //   children: <Widget>[
          //       Text(_blogs[index]['title']),
          //       Text(_blogs[index]['content']),
          //       Text(_blogs[index]['userID']),
          //       Text(_blogs[index]['createdAt']),
          //     ],
          //  );
          return BlogCard(
            title: _blogs[index]['title'],
            content: _blogs[index]['content'],
            user: _blogs[index]['userID'],
            createdAt: _blogs[index]['createdAt'],
            id: _blogs[index]['id'],
          );
        },
      ),
      floatingActionButton: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostBlogPage(),
            ),
          );
        },
      ),
    );
  }
}
