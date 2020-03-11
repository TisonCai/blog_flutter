

import 'package:my_blog/models/index.dart';

class CustomPost {
    num id;
    String title;
    Category category;
    List<Tag> tags;
    User owner;
    String create_time;
    String desc;
  static CustomPost fromjson(Map<String,dynamic> json) {
    final category_map = json['category'] as Map<String, dynamic>;
    final tag_list = json['tag'] as List;
    List<Tag> taglist = List<Tag>();
    tag_list.forEach((item){  
      taglist.add(Tag.fromJson(item));
    });

    var post = CustomPost()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..create_time = json['create_time'] as String
    ..desc = json['desc'] as String
    ..category = Category.fromJson(category_map)
    ..tags = taglist
    ..owner = User.fromJson(json['owner']);

    return post;
  }
  String tag_string() {
    return this.tags.fold('',(current, element){
        return current + element.name + ',';
      });
  }

}