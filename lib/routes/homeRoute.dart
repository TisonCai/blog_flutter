import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with SingleTickerProviderStateMixin {

  final List<String> tabs = <String>['分类1','分类2','分类4','分类3'];
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('博客主页'),
        bottom: TabBar(
          controller: _controller,
          tabs: tabs.map((e) => Tab(text: e,)).toList(),
        ),
      ),
    );
  }
}