// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..category = json['category'] as Map<String, dynamic>
    ..tag = json['tag'] as List
    ..owner = json['owner'] as Map<String, dynamic>
    ..create_time = json['create_time'] as String
    ..desc = json['desc'] as String;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'tag': instance.tag,
      'owner': instance.owner,
      'create_time': instance.create_time,
      'desc': instance.desc
    };
