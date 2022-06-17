
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_icon_article.dart';
import 'package:newsdx/widgets/small_text.dart';
import 'package:newsdx/widgets/sport_stars.dart';

class SportPageListItem extends StatefulWidget {
  final Sports? sports;
  const SportPageListItem({Key? key,required this. sports}) : super(key: key);

  @override
  State<SportPageListItem> createState() => _SportPageListItemState();
}

class _SportPageListItemState extends State<SportPageListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 112,
      margin: const EdgeInsets.only(top: 12,bottom: 12,right: 16,left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 149.0,
              height: 112.0,
              child: CachedNetworkImage(
                imageUrl: widget.sports!.imgUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  width: 149.0,
                  height: 112.0,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset("assets/images/place_holder.png"),
              ),
            )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(16, Colors.black, 1, widget.sports?.title ?? ""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText("SPORTSTAR .  ", 12, Colors.redAccent, 1.0),
                        SmallText("IPL 2022  ", 12, Colors.black, 1.0),
                      ],
                    ),
                    Row(
                      children: [
                        SmallIconArticle("assets/images/share.png",18.0,17.0),
                      ],
                    )

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


