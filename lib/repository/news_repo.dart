import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:text_reader/models/news_model.dart';

class NewsRepository {
  getNews(String category, String country) async {
    String url = 'https://newsapi.org/v2/top-headlines?country='
        '$country&category=$category&apiKey=c802a954279041b4a61c20e6280f1a6c';

    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return NewsResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    // try {
    //   http.Response response = await http.get(uri);
    //   return NewsResponse.fromJson(jsonDecode(response.body));
    // }catch (e){
    //   return NewsResponse.showError(e).toString();
    // }
  }
}