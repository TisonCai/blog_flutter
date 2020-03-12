
import 'package:my_blog/models/customPost.dart';

import 'network.dart';

class Api {
  static Future<List<CustomPost>> getPosts({Map query=null}) async{
        print("query");
    print(query);
    var response = await Git.get(postList, queryParameters: query);
    List datas = response['result']['data'];
    var models = datas.map((item){
      return CustomPost.fromjson(item);
    });
    print('Post');
    print(models);
    return models.toList();
  }
}