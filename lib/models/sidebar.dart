import 'package:json_annotation/json_annotation.dart';

part 'sidebar.g.dart';

@JsonSerializable()
class Sidebar {
    Sidebar();

    num id;
    String title;
    num display_type;
    List side_list;
    
    factory Sidebar.fromJson(Map<String,dynamic> json) => _$SidebarFromJson(json);
    Map<String, dynamic> toJson() => _$SidebarToJson(this);
}
