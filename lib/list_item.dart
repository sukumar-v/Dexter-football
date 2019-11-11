import 'package:flutter/material.dart';
import 'package:news_app/entity/news.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ListItem extends StatelessWidget {
  final Article article;
  ListItem(this.article);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MyWebView(
              title: article.title,
              selectedUrl: article.url,
            )));
  },
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

class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;
  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
          },
        ));
  }
}