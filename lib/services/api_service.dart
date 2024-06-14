import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/app_config.dart';
import 'package:newsapp/model/news_model.dart';

class ApiService {
  Future<List<Article>> fetchArticles(String keyword) async {
    final response = await http.get(
      Uri.parse(
          '${AppConfig.baseUrl}/everything?q=$keyword&apiKey=${AppConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];
      List<Article> articles =
          articlesJson.map((json) => Article.fromJson(json)).toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
