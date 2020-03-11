import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostDetailRoute extends StatefulWidget {
  String postId;
  PostDetailRoute(String postId) {
    this.postId = postId;
  }

  @override
  _PostDetailRouteState createState() => _PostDetailRouteState();
}

class _PostDetailRouteState extends State<PostDetailRoute> {
  var _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('文章详情'),
      ),
      body: 
      Stack(
        children: <Widget>[
                 WebView(
        initialUrl: 'http://127.0.0.1:8000/post/${this.widget.postId}',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished:(url){
          setState(() {
            _isLoading = false;
          });
          print('$url 加载完成');
        },
        onPageStarted:(url){
          print('$url 开始加载');
        },
      ),
      _isLoading ? LoadingFlipping.circle() : Container(
        constraints: BoxConstraints(maxWidth: 0.01,maxHeight: 0.01),
        ),
        ],
      )
    );
  }
}