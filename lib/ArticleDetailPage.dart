import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String publishedAt;

  ArticleDetailPage({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.publishedAt,
  });

  @override
  Widget build(BuildContext context) {
    // Format the published date if needed
    DateTime dateTime = DateTime.parse(publishedAt);
    String formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            imageUrl.isNotEmpty
                ? Image.network(imageUrl)
                : Icon(Icons.image_not_supported, size: 100),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Published on: $formattedDate',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
