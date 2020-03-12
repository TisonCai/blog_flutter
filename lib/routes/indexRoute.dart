import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:my_blog/common/api.dart';
import 'package:my_blog/common/network.dart';
import 'package:my_blog/models/customPost.dart';
import 'package:my_blog/routes/homeRoute.dart';
import 'package:my_blog/routes/myBolgRoute.dart';
import 'package:my_blog/routes/postDetailRoute.dart';
import 'package:my_blog/routes/sidebarRoute.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void _searchPost() {
    Navigator.pushNamed(context, 'search');
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _bottomItems = <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.school),title: Text('我的博客')),
  ];

  static final Widget _homeRoute = HomeRoute();
  static final Widget _bolgRoute = MyBolgRoute();
  final List<Widget> _routes = <Widget>[
    _homeRoute,
    _bolgRoute,
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
          fixedColor: Colors.blue,
          onTap: _onItemTapped,
          currentIndex: _currentIndex,
        ),
      body: _routes[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context, 
            delegate: SearchBarViewDelegate());
        },
        tooltip: 'Increment',
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class SearchBarViewDelegate extends SearchDelegate<CustomPost>{

  String searchPlaceholder = "请输入关键词搜索...";
  List<CustomPost> tipsList = List<CustomPost>();  // 关键字提示
  List<CustomPost> postlist = List<CustomPost>();  // 缓存搜索历史
  var _isSearch = false;
  BuildContext _context;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.blue,
      primaryTextTheme: TextTheme().apply(
        bodyColor:Colors.white,
        displayColor: Colors.white,
      ),
    );
  }

  @override
  String get searchFieldLabel => searchPlaceholder;

  @override
  List<Widget> buildActions(BuildContext context) {
    _context = context;
    ///显示在最右边的控件列表
    return [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query = "";
        ///搜索建议的内容
        showSuggestions(context);
        },
    ),
      IconButton(
          icon: Icon(Icons.search),
          onPressed: (){
            showResults(context);
          },
      )
    ];
  }

  ///左侧带动画的控件，一般都是返回
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
        ),
        ///调用 close 关闭 search 界面
        onPressed: ()=>close(context,null),
    );
  }

  ///展示搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(delegate: this,query: query,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        constraints: BoxConstraints(maxWidth: 0.01,maxHeight: 0.01),
      );
    }
    return SearchResult(delegate: this,query: query,);
  }
}


abstract class SearchState {}
class SearchError extends SearchState {
  @override
  String toString() => 'SearchError：获取失败';
}

class SearchUninitialized extends SearchState {
  @override
  String toString() => 'SearchUninitialized：未初始化';
}

class SearchLoading extends SearchState {
  @override
  String toString() => 'SearchLoading ：正在加载';
}

class SearchLoaded extends SearchState {
  final List<CustomPost> res;

  SearchLoaded({
    this.res,
  });
  @override
  String toString() => 'SearchLoaded：加载完毕';
}

abstract class SearchEvent {}
class SearchFetch extends SearchEvent {
  String query;
  SearchFetch({this.query});

  @override
  String toString() => 'SearchFetch：获取搜索结果事件';
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => SearchUninitialized();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchFetch) {
      try {
        yield SearchLoading();
        final res = await Api.getPosts(query:{'keyword':event.query});
        yield SearchLoaded(res: res);
      } catch (_) {
        yield SearchError();
      }
    }
  }
}


class SearchResult extends StatefulWidget {
  final SearchDelegate delegate;
  final String query;
  SearchResult({this.delegate, this.query});
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final SearchBloc _search = SearchBloc();
  String old;

 void _onTap(BuildContext context, CustomPost post) {
    print(post.title);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return PostDetailRoute('${post.id}');
    }));
  }

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
                                }),
                                ],
                                )
                                );
  }

  @override
  Widget build(BuildContext context) {
    if (old != widget.query) {
      _search.add(SearchFetch(query: widget.query));
      old = widget.query;
    }
    return BlocBuilder(
      bloc: _search,
      builder: (BuildContext context, SearchState state) {
        if (state is SearchUninitialized || state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchError) {
          return Center(
            child: Text('获取失败'),
          );
        } else if (state is SearchLoaded) {
          return ListView.builder(
        itemCount: state.res.length,
        // itemExtent: 120,
        itemBuilder: (BuildContext context, int index) {
          final model = state.res[index];
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
                    _getRichText('分类：',model.category.name,(){}),
                    _getRichText('  标签：',model.tags.first.name,(){}),
                    _getRichText('  作者：',model.owner.username,(){}),
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
      },
    );
  }
}