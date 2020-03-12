import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_blog/common/api.dart';
import 'package:my_blog/common/network.dart';
import 'package:my_blog/models/customPost.dart';
import 'package:my_blog/models/customSidebar.dart';
import 'package:my_blog/models/index.dart';
import 'package:my_blog/models/post.dart';
import 'package:my_blog/routes/postDetailRoute.dart';
import 'package:my_blog/routes/sidebarRoute.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FilterPostRoute extends StatefulWidget {
  FilterPostRoute({this.title, this.filter});
  String title;
  Map filter;

  @override
  _FilterPostRouteState createState() => _FilterPostRouteState();
}

class _FilterPostRouteState extends State<FilterPostRoute> with SingleTickerProviderStateMixin {

  List<Category> categorys = List<Category>();
  List<CustomPost> postlist = List();

  Widget _getRichText(String normalText,String highText,GestureTapCallback onTap) {
    return   Text.rich(TextSpan(
                text: normalText,
                children: [
                  TextSpan(
                    text: highText,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    // recognizer: TapGestureRecognizer()
                    //             ..onTap = onTap
                                ),
                                ],));
  }

  Widget _getlistView (){
    return ListView.builder(
        itemCount: postlist.length,
        // itemExtent: 120,
        itemBuilder: (BuildContext context, int index) {
          final model = postlist[index];
          return Card(
            child: GestureDetector(
              onTap: () {
                _onTap(context,model);
              },
              child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  textAlign: TextAlign.left,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  ),
                Text(model.desc),
                Row(
                  children: <Widget>[
                    _getRichText('分类：',model.category.name,(){
                                      print(model.category);
                                    }),
                    _getRichText('  标签：',model.tags.first.name,(){
                      print('click me');
                    }),
                    _getRichText('  作者：',model.owner.username,(){
                      print('click me');
                    }),
                  ],
                ),
                ]
            ),
            ),
            )
          );
        }
        );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  
  // network
  void get_postlist({Map query=null}) async {
    var models = await Api.getPosts(query:query);
    print("get_postlistr");
    print(query);
    // var response = await Git.get(postList, queryParameters: query);
    // List datas = response['result']['data'];
    // var models = datas.map((item){
    //   return CustomPost.fromjson(item);
    // });
    print('Filter Post');
    print(models);

    postlist.clear();
    postlist.addAll(models);
    setState(() {
      postlist=postlist;
    });
  }
  void get_postlist_by_category(String cate_id) {
    get_postlist(query: {'category_id':cate_id});
  }
  void get_postlist_by_tag(String tag_id) {
    get_postlist(query: {'tag_id':tag_id});
  }
  void get_postlist_by_author(String user_id) {
    get_postlist(query: {'user_id':user_id});
  }
  void get_postlist_by_search({String keyword=''}) {
    get_postlist(query: {'keyword':keyword});
  }



  void _onRefresh() async{
    // get_categorys();
    // get_sidebarlist();
    // get_postlist();
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

  void _onTap(BuildContext context, CustomPost post) {
    print(post.title);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return PostDetailRoute('${post.id}');
    }));
  }

  @override
  void initState() {
    get_postlist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('博客文章'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text('标签为：的文章'),
          ),
          _getlistView(),
        ],
      )
    );
  }
}