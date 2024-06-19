import 'package:flutter/material.dart';
import 'package:newsapp/providers/news_provider.dart';
import 'package:newsapp/widgets/article_card.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Articles'),
        centerTitle: true,
      ),
      body: newsProvider.bookmarkedArticles.isEmpty
          ? const Center(child: Text('No bookmarks yet'))
          : ListView.builder(
              itemCount: newsProvider.bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = newsProvider.bookmarkedArticles[index];
                return ArticleCard(article: article);
              },
            ),
    );
  }
}
