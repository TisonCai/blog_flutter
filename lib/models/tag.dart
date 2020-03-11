import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
    Tag();

    num id;
    String name;
    String create_time;
    
    factory Tag.fromJson(Map<String,dynamic> json) => _$TagFromJson(json);
    Map<String, dynamic> toJson() => _$TagToJson(this);
}
