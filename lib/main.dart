import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/list_item.dart';
import 'package:http/http.dart' as http;
import 'entity/news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fart.ai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fart.ai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _newsList = new List();

  void getData() async {
    http.Response response = await http.get(
        "https://newsapi.org/v2/everything?q=Premier+League&Language=en&sources=google-news&sortBy=publishedAt&apiKey=fbf16640d2254a00bf510011d70dc3e6");
    setState(() {
      _newsList = News.fromJson(json.decode(response.body)).articles;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) => ListItem(_newsList[index]),
      )),
    );
  }
}

