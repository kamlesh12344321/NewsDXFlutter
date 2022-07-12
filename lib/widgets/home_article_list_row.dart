import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_text.dart';

import '../bookmark/model/bookmark_article.dart';
import '../database/data_helper.dart';
import '../objectbox.g.dart';

class HomeArticleListItem extends StatefulWidget {
  final HomeArticle? articleItem;
   bool? bookmarkStatus;


   HomeArticleListItem({
    Key? key,
    required this.articleItem,
     this.bookmarkStatus,
  }) : super(key: key);

  @override
  State<HomeArticleListItem> createState() => _HomeArticleListItemState();
}

class _HomeArticleListItemState extends State<HomeArticleListItem> {

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    String? _timestamp = widget.articleItem!.publishDate
        .toString(); // [DateTime] formatted as String.
    var _convertedTimestamp =
        DateTime.parse(_timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(_convertedTimestamp);

    if (widget.articleItem!.images!.isNotEmpty) {
      imageUrl =
          "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.articleItem?.images?[0].imageId}_300.jpg";
    } else {
      imageUrl = "https://via.placeholder.com/600x340";
    }
    return Container(
      width: double.infinity,
      height: 112,
      margin: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                SizedBox(
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
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: widget.articleItem?.premium == true ? SvgPicture.asset("assets/dot.svg") : Container(child: Text(""),),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(14, Colors.black, 1, widget.articleItem?.title ?? ""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText(result, 12, Colors.black, 1.0),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/share.svg"),
                        const SizedBox(
                          width: 18,
                          height: 17,
                        ),
                        IconButton(
                          icon:  widget.bookmarkStatus! ? SvgPicture.asset("assets/bookmark_filled.svg")
                              : SvgPicture.asset("assets/bi_bookmark.svg"),
                          onPressed: () {
                            debugPrint("Home row click bookmark id -> "+widget.articleItem!.articleId);
                            setState(() {
                              if( widget.bookmarkStatus == true){
                                widget.bookmarkStatus = false;
                              } else {
                                widget.bookmarkStatus = true;
                              }
                              debugPrint("selection state -> " +  widget.bookmarkStatus.toString());
                            });
                            onBookmark(widget.articleItem!.articleId);
                          },
                        )
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

  void onBookmark(String articleId) {

    var result = Helpers.queryArticleId(articleId);
    result.then((value) => {
      if (value!.length == 0)
        {
          Helpers.insert(BookMarkArticleModel(articleId: articleId)),
          debugPrint("Bookmark Result added $articleId"),
        }
      else
        {
          Helpers.delete(articleId),
          debugPrint("Bookmark Result remove "+value.first.articleId),
        }
    });

    setState(() {});
  }
}
