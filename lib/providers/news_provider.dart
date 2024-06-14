import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  List<Article> _bookmarkedArticles = [];
  List<Article> get bookmarkedArticles => _bookmarkedArticles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  NewsProvider() {
    fetchArticles("Today");
    _loadBookmarkedArticles();
  }

  Future<void> fetchArticles(String keyword) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _apiService.fetchArticles(keyword);
    } catch (error) {
      _articles = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleBookmark(Article article) async {
    if (_bookmarkedArticles.contains(article)) {
      _bookmarkedArticles.remove(article);
    } else {
      _bookmarkedArticles.add(article);
    }
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'bookmarks',
      json.encode(
        _bookmarkedArticles.map((e) => e.toJson()).toList(),
      ),
    );
  }

  void _loadBookmarkedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bookmarkedArticlesString = prefs.getString('bookmarks');
    if (bookmarkedArticlesString != null) {
      List<dynamic> bookmarkedArticlesJson =
          json.decode(bookmarkedArticlesString);
      _bookmarkedArticles =
          bookmarkedArticlesJson.map((json) => Article.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
