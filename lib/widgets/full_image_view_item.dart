import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/widgets/article_list.dart';

class FullImageViewItem extends StatefulWidget {
 final Article? article;

  const FullImageViewItem({Key? key, this. article}) : super(key: key);

  @override
  State<FullImageViewItem> createState() => _FullImageViewItemState();

}

class _FullImageViewItemState extends State<FullImageViewItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0,top: 10.0,right: 16.0,bottom: 10.0),
      alignment: AlignmentDirectional.bottomStart,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.article?.title ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily:"Fira Sans"
          ),
        ),
      ),
      height: 236,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.article?.images?[0].imageId ?? MyConstant.PLACE_HOLDER)
        )
      ),
    );
  }
}
