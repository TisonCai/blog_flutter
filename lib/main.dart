import 'package:flutter/material.dart';
import 'package:my_blog/routes/homeRoute.dart';
import 'package:my_blog/routes/myBolgRoute.dart';
import 'package:my_blog/routes/sidebarRoute.dart';

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
          showSearch(context: context, delegate: SearchBarViewDelegate());
        },
        tooltip: 'Increment',
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class SearchBarViewDelegate extends SearchDelegate<String>{

  String searchHint = "请输入搜索内容...";
   var sourceList = [
    "dart",
    "dart 入门",
    "flutter",
    "flutter 编程",
    "flutter 编程开发",
  ];

  var  suggestList = [
    "flutter",
    "flutter 编程开发"
  ];


   @override
  String get searchFieldLabel => searchHint;


  @override
  List<Widget> buildActions(BuildContext context) {

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
          onPressed: ()=>query = "",
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

    List<String> result = List();

    ///模拟搜索过程
    for (var str in sourceList){
      ///query 就是输入框的 TextEditingController
      if (query.isNotEmpty && str.contains(query)){
          result.add(str);
      }
    }

    ///展示搜索结果
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index)=>ListTile(
        title: Text(result[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> suggest = query.isEmpty ? suggestList : sourceList.where((input)=>input.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggest.length,
        itemBuilder: (BuildContext context, int index)=>
    InkWell(
      child:         ListTile(
        title: RichText(
          text: TextSpan(
            text: suggest[index].substring(0, query.length),
            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggest[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
        onTap: (){
       //  query.replaceAll("", suggest[index].toString());
          searchHint = "";
          query =  suggest[index].toString();
         showResults(context);
        },
    ),


    );
  }
}
