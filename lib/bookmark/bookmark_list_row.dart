import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_text.dart';
import 'package:get_time_ago/get_time_ago.dart';
import '../database/data_helper.dart';
import '../shared/shared_method.dart';


class BookmarkListRow extends StatefulWidget {
  Articles? articleItem;
  int? rowIndex;
  final Function? callback;

  BookmarkListRow({
    Key? key,
     this.articleItem,
     this.rowIndex,
     this.callback
  }) : super(key: key);

  @override
  State<BookmarkListRow> createState() => _BookmarkListRowState();
}

class _BookmarkListRowState extends State<BookmarkListRow> {

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
                         const SizedBox(
                          width: 14,
                          height: 17,
                        ),
                        IconButton(
                          icon: SvgPicture.asset("assets/bookmark_filled.svg"),
                          onPressed: () {
                            onBookmark(widget.articleItem!.articleid!);
                            widget.callback!(widget.rowIndex);
                            // Provider.of<BookMarkIndex>(context, listen: false).BookMarkRowPosition(1);
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
    Helpers.delete(articleId);
    setState(() {});
  }

}
