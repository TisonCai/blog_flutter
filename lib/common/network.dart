import 'package:dio/dio.dart';

class Git {
  static Dio dio = Dio(BaseOptions(
    baseUrl:'www.badu.com',
  ));

  static a() {
    // Git.dio.get(path)
    // Git.dio.post(path)
  }

}