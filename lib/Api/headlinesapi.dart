import 'package:news/models/headlines.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news/urls.dart';

class HeadLinesApi {
  Future<List<Headlines>> getheahlinenews() async {
    List<Headlines> headnews = List<Headlines>();
    String url = headlines_url;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      var data = jsondata["articles"];
      for (var items in data) {
        Headlines headlines = Headlines(
          author: items['author'].toString(),
          title: items['title'].toString(),
          publishedAt:items['publishedAt'].toString(),
          description: items['description'].toString(),
          urlToImage: items['urlToImage'].toString(),
          source: Source(
            name: items['source']['name'].toString(),
          ),
        );
        headnews.add(headlines);
      }
    }
    return headnews;
  }
}
