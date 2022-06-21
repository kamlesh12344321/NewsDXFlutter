import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/widgets/article_list.dart';
import 'package:newsdx/widgets/big_text.dart';

class FullWidthImageItem extends StatefulWidget {
  final ArticleById? article;


  FullWidthImageItem(this.article);

  @override
  State<FullWidthImageItem> createState() => _FullWidthImageItemState();
}

class _FullWidthImageItemState extends State<FullWidthImageItem> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 10,bottom: 10),
      alignment: AlignmentDirectional.bottomStart,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BigText(16,Colors.white,1,widget.article?.title ?? ""),
      ),
      height: 295,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.article?.images?[0].imageId ?? MyConstant.PLACE_HOLDER)
          )
      ),
    );
  }
}
