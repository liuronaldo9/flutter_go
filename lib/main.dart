import 'package:flutter/material.dart';
import 'package:flutter_go/blog_page.dart';
import 'package:flutter_go/blog_post_page.dart';

import 'auth.dart';
import 'signup.dart';


void main() {
// debugPaintSizeEnabled = true;
runApp(MyApp());
}

class MyApp extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gogox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: AutePage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/signup': (BuildContext context) => SignupPage(),
        '/blogs':(context)=>BlogPage(),
        '/post':(context)=>PostBlogPage()
      },
    );
  }
}