import 'package:flutter/material.dart';
import 'package:news_app/entity/news.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class ListItem extends StatelessWidget {
  final Article article;
  ListItem(this.article);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
            //Use`Navigator` widget to push the second screen to out stack of screens
            Navigator.of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new SecondScreen();
            }));
          },
      // padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Row(
        children: <Widget>[
          Container(
            height: 80,
            width: 100,
            child: Image.network(article.urlToImage),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      article.description,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                    )
                  ]),
            ),
          )
        ],
      )),
    );
  }
}

class SecondScreen extends StatelessWidget {
  // final Article article;
  // ListItem(this.article);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
          url: "https://www.google.com",
          appBar: new AppBar(
            title: new Text("defalut"),
          ),
        ),
      },
    );

  }
}