import 'package:http/http.dart' as http;
import 'dart:convert';

class Article {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  DateTime publishedAt;

  Article(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.publishedAt});
}

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&apiKey=e46ec93b3b2045bf9a19b5bb89a74674';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Article article = Article(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              publishedAt: DateTime.parse(element["publishedAt"]));
          news.add(article);
        }
      });
    }
  }
}
