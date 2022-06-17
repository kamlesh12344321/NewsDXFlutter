import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_icon_article.dart';
import 'package:newsdx/widgets/small_text.dart';


class HomePageListItem extends StatefulWidget {
  final String? articleTitle;
  final String? articleImageUrl;

  const HomePageListItem(
      {Key? key, required this.articleTitle, required this.articleImageUrl})
      : super(key: key);

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 112,
      margin: const EdgeInsets.only(top: 12, bottom: 12,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 149.0,
              height: 112.0,
              child: CachedNetworkImage(
                imageUrl: widget.articleImageUrl!,
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
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(16, Colors.black, 1, widget.articleTitle ?? ""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText("National  ", 12, Colors.black, 1.0),
                        SmallText("Time  ", 12, Colors.black, 1.0),
                      ],
                    ),
                    Row(
                      children: [
                        SmallIconArticle(
                          'assets/images/share.png',
                          18.0,
                          17.0,
                        ),
                        const SizedBox(
                          width: 18,
                          height: 17,
                        ),
                        SmallIconArticle("assets/images/fav.png", 18.0, 17.0),
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
