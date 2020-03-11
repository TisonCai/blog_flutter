import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:my_blog/common/network.dart';
import 'package:my_blog/models/customSidebar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostSearchRoute extends StatefulWidget {
  @override
  _PostSearchRouteState createState() => _PostSearchRouteState();
}

class _PostSearchRouteState extends State<PostSearchRoute> {

  Widget searchBar() {
    return Row(
      children: <Widget>[
        
      ],
    );
  }
  Widget searchList() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}