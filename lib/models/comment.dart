import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
    Comment();

    String content;
    String nickname;
    String website;
    String email;
    String create_time;
    num id;
    
    factory Comment.fromJson(Map<String,dynamic> json) => _$CommentFromJson(json);
    Map<String, dynamic> toJson() => _$CommentToJson(this);
}
