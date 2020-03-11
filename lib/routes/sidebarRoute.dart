import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:my_blog/common/network.dart';
import 'package:my_blog/models/customSidebar.dart';
import 'package:webview_flutter/webview_flutter.dart';


class SidebarRoute extends StatefulWidget {
  @override
  _SidebarRouteState createState() => _SidebarRouteState();
}

class _SidebarRouteState extends State<SidebarRoute> {
  List<CustomSidebar> sidebars = List<CustomSidebar>();

  @override
  void initState() {
    get_sidebarlist();
    super.initState();
  }

  void get_sidebarlist() async {
    var response = await Git.get(sidebarList);
    List datas = response['result']['data'];
    datas.forEach((item){
      CustomSidebar bar = CustomSidebar.fromjson(item);
      print('Sidebars item');
      print(bar.side_list.length);
      print(bar.display_type);
    });
    print('Sidebars');
    print(response);
  }

  Widget _listView() {
    return ListView.builder(
        itemCount: sidebars.length,
        // itemExtent: 120,
        itemBuilder: (BuildContext context, int index) {
          final model = sidebars[index];
          return Card(
            child: GestureDetector(
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
                // Text(model.desc),
                ]
            ),
            ),
            )
          );
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listView(),
    );
  }
}