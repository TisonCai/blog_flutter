import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
    Post();

    num id;
    String title;
    Map<String,dynamic> category;
    List tag;
    Map<String,dynamic> owner;
    String create_time;
    String desc;
    
    factory Post.fromJson(Map<String,dynamic> json) => _$PostFromJson(json);
    Map<String, dynamic> toJson() => _$PostToJson(this);
}
