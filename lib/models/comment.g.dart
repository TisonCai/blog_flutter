// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..content = json['content'] as String
    ..nickname = json['nickname'] as String
    ..website = json['website'] as String
    ..email = json['email'] as String
    ..create_time = json['create_time'] as String
    ..id = json['id'] as num;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'content': instance.content,
      'nickname': instance.nickname,
      'website': instance.website,
      'email': instance.email,
      'create_time': instance.create_time,
      'id': instance.id
    };
