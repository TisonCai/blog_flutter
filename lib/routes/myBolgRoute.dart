import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:loading_animations/loading_animations.dart';

class MyBolgRoute extends StatefulWidget  {
  @override
  _MyBolgRouteState createState() => _MyBolgRouteState();
}

class _MyBolgRouteState extends State<MyBolgRoute> {

  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的博客'),
      ),
      body: 
      Stack(
        children: <Widget>[
                 WebView(
        initialUrl: 'http://localhost:8000/admin/',
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
