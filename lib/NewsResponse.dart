class NewsResponse {
 final String? status;
 final int? totalResults;
 final List<Article>? articles;

 const NewsResponse({this.status, this.totalResults, this.articles});

 NewsResponse.fromJson(Map<String, dynamic> jsonMap)
     : status = jsonMap['status'],
      totalResults = jsonMap['totalResults'],
      articles = (jsonMap['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
}

class Article {
 final String? title;
 final String? description;
 final String? url;
 final String? urlToImage;
 final String? publishedAt;
 final String? content;

 const Article(
     {this.title,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.description,
      this.url});

 Article.fromJson(Map<String, dynamic> jsonMap)
     : title = jsonMap['title'],
      urlToImage = jsonMap['urlToImage'],
      publishedAt = jsonMap['publishedAt'],
      description = jsonMap['description'],
      url = jsonMap['url'],
      content = jsonMap['content'];
}
