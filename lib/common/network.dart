import 'package:dio/dio.dart';

final postList = 'post';
final categoryList = 'category';
final sidebarList = 'sidebar';


class Git {
  static Dio dio = Dio(BaseOptions(
    baseUrl:'http://localhost:8000/api/',
  ));

  static get(String api,{Map queryParameters=null}) async {
    print("queryParameters");
    print(queryParameters);
    var params = null;
    if (queryParameters != null) {
      params = new Map<String,dynamic>.from(queryParameters);
    }
    print('params');
    print(params);
    final fullPath = dio.options.baseUrl + api;
    var result = await Git.dio.get(fullPath,queryParameters: params);
    print('result');
    print(result);
    return result.data;
    // Git.dio.get(path)r
    // Git.dio.post(path)
  }
}