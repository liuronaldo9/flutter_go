import 'package:flutter/material.dart';
import 'package:flutter_go/blog_card.dart';

class CreateBlogPage extends StatefulWidget {
  @override
  _CreateBlogPageState createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  List<dynamic> _blogs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ORDERS'),
      ),
      backgroundColor: Colors.grey,
      body: ListView.builder(
        itemCount: _blogs.length,
        itemBuilder: (context, index) {
          return BlogCard(
            title: _blogs[1],
          );
        },
      ),
    );
  }
}
