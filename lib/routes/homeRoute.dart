import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with SingleTickerProviderStateMixin {

  final List<String> tabs = <String>['分类1','分类2','分类4','分类3'];
  TabController _controller;

  Widget _getRichText(String normalText,String highText,GestureTapCallback onTap) {
    return   Text.rich(TextSpan(
                text: normalText,
                children: [
                  TextSpan(
                    text: highText,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  print('click me');
                                }),],));
  }

  Widget _getlistView (){
    return ListView.builder(
        itemCount: 100,
        itemExtent: 90,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '风科技的了房间爱上方方达冷风机阿里卷达冷风机阿里达冷风机阿里发梳发送',
                  textAlign: TextAlign.left,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  ),
                Text('描述'),

                Row(
                  children: <Widget>[
                    _getRichText('分类：','哈哈',(){
                                      print('click me');
                                    }),
                    _getRichText('  标签：','哈哈',(){
                      print('click me');
                    }),
                    _getRichText('  作者：','哈哈',(){
                      print('click me');
                    }),
                  ],
                ),
                ]
            ),
            )
          );
        }
        );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    _refreshController.loadComplete();
  }

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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: _getlistView(),
        )
    );
  }
}