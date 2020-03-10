// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sidebar _$SidebarFromJson(Map<String, dynamic> json) {
  return Sidebar()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..display_type = json['display_type'] as num
    ..side_list = json['side_list'] as List;
}

Map<String, dynamic> _$SidebarToJson(Sidebar instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'display_type': instance.display_type,
      'side_list': instance.side_list
    };
