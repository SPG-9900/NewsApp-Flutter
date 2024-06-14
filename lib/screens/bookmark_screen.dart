import 'package:flutter/material.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/providers/news_provider.dart';
import 'package:newsapp/screens/article_details_screen.dart';
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
                return BookmarkArticleCard(article: article);
              },
            ),
    );
  }
}

class BookmarkArticleCard extends StatelessWidget {
  final Article article;

  const BookmarkArticleCard({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article),
          ),
        );
      },
      child: Card(
        color: Colors.grey.shade300,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage.isNotEmpty)
                Hero(
                  tag: article.urlToImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      article.urlToImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                article.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(article.description),
            ],
          ),
        ),
      ),
    );
  }
}
