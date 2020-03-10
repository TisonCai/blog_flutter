
import 'package:my_blog/models/index.dart';

class CustomSidebar {
    num id;
    String title;
    num display_type;
    List side_list;
  static CustomSidebar fromjson(Map<String,dynamic> json) {
    List side_list = json['side_list'];
    
    num display_type = json['display_type'] as num;

    var sidebar = CustomSidebar()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..display_type = json['display_type'] as num;

    List<dynamic> models = List();
    switch(display_type) {
      case 4: { // 最新评论
        side_list.forEach((item){
          models.add(Comment.fromJson(item));
        });
        print('最新评论');
        print(models);
      }
      break;
      case 5: { // 关于博主，optional
        side_list.forEach((item){
          models.add(User.fromJson(item));
        });
      }
      break;
      case 3: { // 热门文章
        side_list.forEach((item){
          models.add(Post.fromJson(item));
        });
      }
    }

    sidebar.side_list = models;
    return sidebar;
  }
}