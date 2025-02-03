import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // Add this import
import 'ArticleDetailPage.dart';
import 'NewsResponse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<String>? newsItem = ["news 1", "new 2"];
  List<Article>? newsItems = [];

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=Apple&from=2025-02-01&sortBy=popularity&apiKey=21f34cf7c9664232862801fc927db961"));
    //print(response);
    if (response.statusCode == 200) {
      NewsResponse newsResponse = NewsResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      setState(() {
        newsItems = newsResponse.articles;
      });
    } else {
      throw Exception("Failed to load news");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:  ListView.builder(
          itemCount: newsItems?.length,
          itemBuilder: (BuildContext context, int index) {
            Article article = newsItems![index];

            return ListTile(

              onTap: () {
                // Navigate to the detail page with the article data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailPage(
                      title: article.title ?? 'No title',
                      imageUrl: article.urlToImage ?? '',
                      description: article.description ?? 'No description available',
                      publishedAt: article.publishedAt ?? '',
                    ),
                  ),
                );
              },
              contentPadding: EdgeInsets.all(10),
              title: Text(
                article.title ?? 'No title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Text(article.publishedAt ?? 'No date available'),
              leading: article.urlToImage != null
                  ? Image.network(
                article.urlToImage!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              )
                  : Icon(Icons.image_not_supported),
            );
          },
        ),
      ),
    );
  }
}