import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_blog/common/network.dart';
import 'package:my_blog/models/customPost.dart';
import 'package:my_blog/models/customSidebar.dart';
import 'package:my_blog/models/index.dart';
import 'package:my_blog/models/post.dart';
import 'package:my_blog/routes/postDetailRoute.dart';
import 'package:my_blog/routes/sidebarRoute.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with SingleTickerProviderStateMixin {

  List<Category> categorys = List<Category>();
  List<CustomPost> postlist = List();
  TabController _controller;
  var selectIndex = '11';

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
    print("query");
    print(query);
    var response = await Git.get(postList, queryParameters: query);
    List datas = response['result']['data'];
    var models = datas.map((item){
      return CustomPost.fromjson(item);
    });
    print('Post');
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

  void get_categorys() async {
    var response = await Git.get(categoryList);
    List datas = response['result']['data'];
    var models = datas.map((item){
      return Category.fromJson(item);
    });
    print('Category');
    categorys.clear();
    categorys.addAll(models);

    _controller = TabController(length: categorys.length, vsync: this);
    setState(() {
      categorys = categorys;
    });
    models.forEach((model){print(model.name);});
  }

  void _onRefresh() async{
    get_categorys();
    get_postlist_by_category(selectIndex);
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
    get_categorys();
    get_postlist_by_category(selectIndex);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SidebarRoute(),
      ),
      appBar: AppBar(
        title: Text('博客主页'),
        bottom: categorys.length > 0 ? TabBar(
          controller: _controller,
          tabs: categorys.map((e) => Tab(text: e.name,)).toList(),
          isScrollable: true,
          onTap: (index){
            var category = categorys.elementAt(index);
            selectIndex = category.id.toString();
            print(category.name);
            get_postlist_by_category(selectIndex);
          },
        ) : null,
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
              body = Text("加载失败，请重试!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("释放加载更多");
            }
            else{
              body = Text("没有更多数据了");
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