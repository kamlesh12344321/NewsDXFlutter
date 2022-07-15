import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_text.dart';
import 'package:get_time_ago/get_time_ago.dart';
import '../bookmark/model/bookmark_article.dart';
import '../database/data_helper.dart';
import '../shared/shared_method.dart';


class HomePageListItem extends StatefulWidget {
  final Articles? articleItem;
  bool? bookmarkStatus;

  HomePageListItem({
    Key? key,
    required this.articleItem,
    this.bookmarkStatus
  }) : super(key: key);

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    String? timestamp =
        widget.articleItem!.publishdate; // [DateTime] formatted as String.
    var convertedTimestamp =
        DateTime.parse(timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(convertedTimestamp);

    if (widget.articleItem!.images!.isNotEmpty) {
      imageUrl =
          "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.articleItem?.images?[0].imageid}_300.jpg";
    } else {
      imageUrl = "https://via.placeholder.com/600x340";
    }

    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                SizedBox(
                  width: 149.0,
                  height: 100.0,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 149.0,
                      height: 100.0,
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
                         InkWell(
                           child:  SvgPicture.asset("assets/share.svg"),
                           onTap: (){
                             Shared.onArticleShare(context,
                                 widget.articleItem!.title!,
                                 widget.articleItem!.link!);
                           },
                         ),
                        IconButton(
                          icon:  widget.bookmarkStatus!
                              ? SvgPicture.asset("assets/bookmark_filled.svg")
                              : SvgPicture.asset("assets/bi_bookmark.svg"),
                          onPressed: () {
                            setState(() {
                              if( widget.bookmarkStatus == true){
                                widget.bookmarkStatus = false;
                              } else {
                                widget.bookmarkStatus = true;
                              }
                            });
                            onBookmark(widget.articleItem!.articleid!);
                          },
                        ),
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
      if (value!.isEmpty)
        {
          Helpers.insert(BookMarkArticleModel(articleId: articleId)),
          debugPrint("Bookmark Result added $articleId"),
        }
      else
        {
          Helpers.delete(articleId),
          debugPrint("Bookmark Result remove ${value.first.articleId}"),
        }
    });

    setState(() {});
  }

}
