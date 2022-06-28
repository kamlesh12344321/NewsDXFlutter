import 'package:flutter/material.dart';
import 'package:newsdx/model/SectionPojo.dart';

class ArticleDetail extends StatelessWidget {
  final Articles? articleItem;

  const ArticleDetail({Key? key,this.articleItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Center(
            child: Text(articleItem!.title!),
          ),
    );
  }
}
