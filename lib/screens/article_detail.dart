import 'package:flutter/material.dart';
import 'package:newsdx/model/home_section.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;
  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(article.title),
        ),
      ),
    );
  }
}
