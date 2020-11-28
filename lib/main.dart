import 'package:flutter/material.dart';
import 'package:tes/news.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(primaryColor: Colors.white),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Article> articles = new List<Article>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();

    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "YUVI",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "NEWS",
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return Blog(
                              image: articles[index].urlToImage,
                              desc: articles[index].description,
                              title: articles[index].title,
                              url: articles[index].url,
                              author: articles[index].author,
                              de: articles[index].publishedAt,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}

class Blog extends StatelessWidget {
  final String image, title, desc, url, author;
  final DateTime de;
  Blog(
      {@required this.image,
      @required this.title,
      @required this.desc,
      @required this.url,
      @required this.de,
      @required this.author});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(image)),
          SizedBox(
            height: 8,
          ),
          Text(title,
              style: TextStyle(
                  color: Color(0xFF02D4BF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 4,
          ),
          Text(desc, style: TextStyle(color: Colors.grey, fontSize: 10)),
          SizedBox(
            height: 4,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(author, style: TextStyle(color: Colors.white))),
          SizedBox(
            height: 4,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(de.toString().substring(0, 20),
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
