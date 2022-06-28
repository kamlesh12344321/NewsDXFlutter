import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/model/SectionPojo.dart';

class FullImageViewItemG extends StatefulWidget {
  final Articles? article;

  const FullImageViewItemG({Key? key, this. article}) : super(key: key);

  @override
  State<FullImageViewItemG> createState() => _FullImageViewItemState();
}

class _FullImageViewItemState extends State<FullImageViewItemG> {

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    if(widget.article!.images!.isNotEmpty){
      imageUrl = "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.article!.images![0].imageid}.jpg";
    }
    print(imageUrl);
    return Container(
      margin: const EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 10.0),
      alignment: AlignmentDirectional.bottomStart,
      height: 236,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage( imageUrl ??  MyConstant.PLACE_HOLDER),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(""),
      ),
    );
  }
}
