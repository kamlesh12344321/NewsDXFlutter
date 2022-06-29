import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newsdx/model/SectionPojo.dart';import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_icon_article.dart';
import 'package:newsdx/widgets/small_text.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:get_time_ago/get_time_ago.dart';


class HomePageListItem extends StatefulWidget {
  final Articles? articleItem;


  HomePageListItem({required this.articleItem});

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    String? _timestamp = widget.articleItem!.publishdate; // [DateTime] formatted as String.
    var _convertedTimestamp = DateTime.parse(_timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(_convertedTimestamp);

    if(widget.articleItem!.images!.isNotEmpty) {
       imageUrl = "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.articleItem?.images?[0].imageid}_100.jpg";
    } else{
      imageUrl = "https://via.placeholder.com/600x340";
    }
    return Container(
      width: double.infinity,
      height: 112,
      margin: const EdgeInsets.only(top: 12, bottom: 12, left: 16 , right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: 149.0,
              height: 112.0,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 149.0,
                  height: 112.0,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(16, Colors.black, 1, widget.articleItem?.title ?? ""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText(result , 12, Colors.black, 1.0),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/share.svg"),
                         const SizedBox(
                          width: 18,
                          height: 17,
                        ),
                        SvgPicture.asset("assets/bi_bookmark.svg"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
