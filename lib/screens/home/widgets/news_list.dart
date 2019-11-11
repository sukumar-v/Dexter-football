import 'package:flutter/material.dart';
import 'package:dexter/widgets/dex_news.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (context, index) => Divider(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return DexNews(
          title: "Is Liverpool vs Man City the Premier League title decider?",
          time: "10 Nov 2019",
          thumbnail: Image.asset("assets/images/sample-news.jpg"),
        );
      },
    );
  }
}
