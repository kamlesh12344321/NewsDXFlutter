import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/widgets/article_list.dart';

class FullImageViewItem extends StatefulWidget {
 final HomeArticle? article;

  const FullImageViewItem({Key? key, this. article}) : super(key: key);

  @override
  State<FullImageViewItem> createState() => _FullImageViewItemState();
}

class _FullImageViewItemState extends State<FullImageViewItem> {

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    if(widget.article!.images.isNotEmpty){
       imageUrl = "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.article!.images[0].imageId}_600.jpg";
    }
    print(imageUrl);
    return Container(
      margin: const EdgeInsets.only(left: 16.0,top: 10.0,right: 16.0,bottom: 10.0),
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
        child: Text(
          widget.article?.title ?? "",
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
    );
  }
}
