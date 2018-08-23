import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogCard extends StatefulWidget {
  BlogCard({
    Key key,
    @required this.user,
    @required this.title,
    @required this.content,
    @required this.createdAt,
    this.id,
    this.updatedAt,
  }) : super(key: key);

  final id;
  final title;
  final content;
  final createdAt;
  final updatedAt;
  final user;

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  Future<dynamic> deleteBlog(String bid) async {
    final response = await http
        .delete('https://dev.gogox.co.nz/v1/core/testblog/blog?id=' + bid);
    final int statusCode = response.statusCode;
    if (statusCode == 200) {
      this.dispose();
      return 'success';
    } else {
      return 'failed';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      //height: 190.0,
      child: SizedBox(
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text(widget.title),
              ),
              Divider(
                height: 0.0,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text(widget.content),
                    Text(widget.user),
                    Text(widget.createdAt),
                    RaisedButton(
                      child: Text('delete'),
                      onPressed: () {
                        deleteBlog(widget.id);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
