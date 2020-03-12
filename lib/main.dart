import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:my_blog/routes/homeRoute.dart';
import 'package:my_blog/routes/indexRoute.dart';
import 'package:my_blog/routes/myBolgRoute.dart';
import 'package:my_blog/routes/postDetailRoute.dart';
import 'package:my_blog/routes/sidebarRoute.dart';

import 'common/network.dart';
import 'models/customPost.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Bolg'),
        'home': (context) => HomeRoute(),
        'myBlog': (context) => MyBolgRoute(),
        'search': (context) => SidebarRoute(),
      },
    );
  }
}