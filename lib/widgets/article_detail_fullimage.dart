import 'package:flutter/material.dart';

class FullImageViewItemG extends StatefulWidget {
  final String? articleImage;

  const FullImageViewItemG({Key? key, this. articleImage}) : super(key: key);

  @override
  State<FullImageViewItemG> createState() => _FullImageViewItemState();
}

class _FullImageViewItemState extends State<FullImageViewItemG> {

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    if(widget.articleImage!.isNotEmpty){
      imageUrl = "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.articleImage}_600.jpg";
    }
    return Container(
      margin: const EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 10.0),
      alignment: AlignmentDirectional.bottomStart,
      height: 236,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage( imageUrl),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(""),
      ),
    );
  }
}
