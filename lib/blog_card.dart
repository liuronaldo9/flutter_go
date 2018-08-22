import 'package:flutter/material.dart';

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
                    Text(widget.user + " @" + widget.createdAt),
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
